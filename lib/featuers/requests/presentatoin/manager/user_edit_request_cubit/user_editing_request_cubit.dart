import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

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
    int daysToAdd = (DateTime.friday - now.weekday + 7) % 7;
    if (daysToAdd == 0) {
      daysToAdd = 7;
    }

    DateTime nextFriday = now.add(Duration(days: daysToAdd));
    final DateTime? pickedDate = await showDatePicker(
      helpText: 'Pick the date',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: nextFriday,
    );
    selectedDate = pickedDate;
    if (pickedDate != null && selectedDate != null) {
      emit(UserSelectTheDateSuccess(pickedDate));
    } else {
      emit(UserEditingRequestFailer('The operation has been cancelled'));
    }
  }

  Future<void> selectStartTime(
    BuildContext context,
  ) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      helpText: 'Edit start time',
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
      emit(UserEditingRequestFailer('The operation has been cancelled'));
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
      helpText: 'Edit end time',
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
          }

          if (requestFound) {
            batch.commit().then((_) {
              emit(UserUptadingRequestSuccess(
                  'You Have Updated Your Request from ${selectedStartTime!.format(context)} to ${selectedEndTime!.format(context)} on ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'));
            }).catchError((error) {
              emit(
                  UserEditingRequestFailer('Failed to update request: $error'));
            });
          }
        });
      } else {
        _checkAllSelections(
            hallId: hallId,
            requestId: requestId,
            userId: userId,
            context: context);
      }
    } else {
      emit(UserEditingRequestFailer('The operation has been cancelled'));
    }
  }

  void _checkAllSelections(
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
            'The start time is after the end time'));
      } else if (startDateTime == endDateTime) {
        emit(TheStartTImeTheSameAsTheEndTime(
            'The start time can\'t be the same as the end time'));
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

            bool conflict = startDateTime.isBefore(docEndTime.toDate()) &&
                endDateTime.isAfter(docStartTime.toDate());
            if (conflict) {
              hasConflict = true;
              emit(ThereWasConflict(
                  'There was a conflict with another reservation'));
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
                  'You Have Updated Your Request from ${selectedStartTime!.format(context)} to ${selectedEndTime!.format(context)} on ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'));
            });
          });
        });
      }
    }
  }
}
