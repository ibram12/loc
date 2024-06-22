import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/user_request_model.dart';

part 'user_editing_request_state.dart';

class UserEditingRequestCubit extends Cubit<UserEditingRequestState> {
  UserEditingRequestCubit() : super(UserEditingRequestInitial());

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  void selectDate(
    BuildContext context,
  ) async {
    DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      helpText: S.of(context).pick_the_date,
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year, now.month + 1, 0),
    );
    selectedDate = pickedDate;
    if (pickedDate != null && selectedDate != null) {
      emit(UserSelectTheDateSuccess(pickedDate));
    } else {
      emit(UserEditingRequestFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  Future<void> selectStartTime(
    BuildContext context,
  ) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      helpText: S.of(context).edit_start_time,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null && selectedDate != null) {
      selectedStartTime = pickedStartTime;
      final pickedDateTime = DateTime(selectedDate!.year, selectedDate!.month,
          selectedDate!.day, pickedStartTime.hour, pickedStartTime.minute);
      Timestamp pickedStartTimeTemp = Timestamp.fromDate(pickedDateTime);
      emit(UserSelectStartTimeSuccess(pickedStartTimeTemp));
    } else {
      emit(UserEditingRequestFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  void selectEndTime(
      BuildContext context,
      String hallId,
      String requestId,
      String userId,
      Timestamp initialStartTime,
      Timestamp initialEndTime) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      helpText: S.of(context).edit_end_time,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null && selectedDate != null) {
      selectedEndTime = pickedEndTime;
      final pickedEndDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          pickedEndTime.hour,
          pickedEndTime.minute);
      Timestamp pickedEndTimeTemp = Timestamp.fromDate(pickedEndDateTime);
      emit(UserSelectEndTimeSuccess(pickedEndTimeTemp));
      final startDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedStartTime!.hour,
        selectedStartTime!.minute,
      );

      final endDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedEndTime!.hour,
        selectedEndTime!.minute,
      );
      if (endDateTime.isAfter(initialStartTime.toDate()) &&
          startDateTime.isBefore(initialEndTime.toDate())) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        FirebaseFirestore.instance
            .collection('locs')
            .doc(hallId)
            .collection('reservations')
            .get()
            .then((value) {
          bool requestFound = false;
          for (var element in value.docs) {
            if(element.exists){
                if (element.get('requestId') == requestId) {
              requestFound = true;
              List<String> pathsToUpdate = [
                'locs/$hallId/reservations/${element.reference.id}',
                'users/$userId/requests/$requestId',
              ];

              for (var path in pathsToUpdate) {
                batch.update(FirebaseFirestore.instance.doc(path), {
                  'startTime': Timestamp.fromDate(startDateTime),
                  'endTime': Timestamp.fromDate(endDateTime),
                });
              }
              break; 
            }
            }else{
              emit(UserEditingRequestFailer('you can not edit this request because it is not found'));
            }
          
          }

          if (requestFound) {
            batch.commit().then((_) {
              emit(UserUptadingRequestSuccess(
                  '${S.of(context).user_edit_request_cubit_in_requests_feature_you_have_updated_your_request_from}: ${selectedStartTime!.format(context)} ${S.of(context).to} ${selectedEndTime!.format(context)} ${S.of(context).on} ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'));
            }).catchError((error) {
              emit(
                  UserEditingRequestFailer('${S.of(context).user_edit_request_cubit_in_requests_feature_failed_to_update_request} $error'));
            });
          }
        });
      } else {
        _checkAllInAllReservaions(
            hallId: hallId,
            requestId: requestId,
            userId: userId,
            context: context);
      }
    } else {
      emit(UserEditingRequestFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  void _checkAllInAllReservaions(
      {required String hallId,
      required String requestId,
      required String userId,
      required BuildContext context}) {
    if (selectedDate != null &&
        selectedStartTime != null &&
        selectedEndTime != null) {
      final startDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedStartTime!.hour,
        selectedStartTime!.minute,
      );

      final endDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedEndTime!.hour,
        selectedEndTime!.minute,
      );

      if (startDateTime.isAfter(endDateTime)) {
        emit(TheStartTimeIsAfterTheEndTime(
            S.of(context).the_start_time_is_after_the_end_time));
      } else if (startDateTime == endDateTime) {
        emit(TheStartTImeTheSameAsTheEndTime(
            S.of(context).the_start_time_cant_be_the_same_as_the_end_time));
      } else {
        emit(UserEditingRequestLoading());
        WriteBatch batch = FirebaseFirestore.instance.batch();
        bool canEdit = false;
        bool hasConflict = false;
        FirebaseFirestore.instance
            .collection('locs')
            .doc(hallId)
            .collection('reservations')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            Timestamp docStartTime = element.get('startTime');

            Timestamp docEndTime = element.get('endTime');

            String replayState = element.get('replyState');

            bool conflict = startDateTime.isBefore(docEndTime.toDate()) &&
                endDateTime.isAfter(docStartTime.toDate())&& replayState != ReplyState.unaccepted.description;
            if (conflict) {
              hasConflict = true;
              emit(ThereWasConflict(
                  S.of(context).there_was_a_conflict_with_another_reservation));
              return;
            }
            if (element.get('requestId') == requestId) {
              canEdit = true;
              batch.update(element.reference, {
                'startTime': Timestamp.fromDate(startDateTime),
                'endTime': Timestamp.fromDate(endDateTime),
              });
            }
          });
        }).then((_) {
          if (!canEdit || hasConflict) {
            return;
          }

          FirebaseFirestore.instance
              .doc('users/$userId/requests/$requestId')
              .update({
            'startTime': Timestamp.fromDate(startDateTime),
            'endTime': Timestamp.fromDate(endDateTime),
          }).then((_) {
            batch.commit().then((_) {
              emit(UserUptadingRequestSuccess(
                  '${S.of(context).user_edit_request_cubit_in_requests_feature_you_have_updated_your_request_from}: ${selectedStartTime!.format(context)} ${S.of(context).to} ${selectedEndTime!.format(context)} ${S.of(context).on} ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'));
            });
          });
        });
      }
    }
  }
}
