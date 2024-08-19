import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:meta/meta.dart';

import '../../../../../core/notifications/get_user_token.dart';
import '../../../../../core/server/shered_pref_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../requests/data/models/user_request_model.dart';

part 'edit_request_state.dart';

class EditRequestCubit extends Cubit<EditRequestState> {
  EditRequestCubit() : super(EditRequestInitial());
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
      emit(EditTheDateSuccess(pickedDate));
    } else {
      emit(EditRequestFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  Future<void> selectStartTime(
    BuildContext context,
    Timestamp initialStartTime,
  ) async {
    int hour = initialStartTime.toDate().hour;
    int minute = initialStartTime.toDate().minute;
    final TimeOfDay? pickedStartTime = await showTimePicker(
      helpText: S.of(context).edit_start_time,
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );
    if (pickedStartTime != null && selectedDate != null) {
      selectedStartTime = pickedStartTime;
      final pickedDateTime = DateTime(selectedDate!.year, selectedDate!.month,
          selectedDate!.day, pickedStartTime.hour, pickedStartTime.minute);
      Timestamp pickedStartTimeTemp = Timestamp.fromDate(pickedDateTime);
      emit(EditStartTimeSuccess(pickedStartTimeTemp));
    } else {
      emit(EditRequestFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  void selectEndTime(
      BuildContext context,
      String hallId,
      String requestId,
      String userId,
      Timestamp initialEndTime,
      Timestamp initialStartTime,
      String reservationId,
      String userToken) async {
    int hour = initialEndTime.toDate().hour;
    int minute = initialEndTime.toDate().minute;
    final TimeOfDay? pickedEndTime = await showTimePicker(
      helpText: S.of(context).edit_end_time,
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );
    if (pickedEndTime != null && selectedDate != null) {
      String? adminName = await SherdPrefHelper().getUserName();
      selectedEndTime = pickedEndTime;
      final pickedEndDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          pickedEndTime.hour,
          pickedEndTime.minute);
      Timestamp pickedEndTimeTemp = Timestamp.fromDate(pickedEndDateTime);
      emit(EditEndTimeSuccess(pickedEndTimeTemp));
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
        List<String> pathsToUpdate = [
          'locs/$hallId/reservations/$reservationId',
          'users/$userId/requests/$requestId',
        ];

        for (var path in pathsToUpdate) {
          await FirebaseFirestore.instance.doc(path).update({
            'modifiedDoc': reservationId,
            'replyState': ReplyState.modified.description,
            'modifer': adminName,
            'adminModified': true,
            'startTime': Timestamp.fromDate(startDateTime),
            'endTime': Timestamp.fromDate(endDateTime),
          });
          break;
        }
        PushNotificationService.sendNotificationToSelectedUser(
          deviceToken: userToken,
          screen: UserRequests.id,
          title: 'طلب تعديل',
          body:
              'طلب تعديل طلبك من ${DateFormat('hh-mm a').format(initialStartTime.toDate())} الي ${selectedStartTime!.format(context)}',
        );
        emit(EditRequestSuccess(
            '${S.of(context).you_have_updated_request_from} ${selectedStartTime!.format(context)} ${S.of(context).to} ${selectedEndTime!.format(context)} ${S.of(context).on} ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'));
      } else {
        _checkAllSelections(
            // ignore: use_build_context_synchronously
            context: context,
            userToken: userToken,
            hallId: hallId,
            requestId: requestId,
            userId: userId,
            reservationId: reservationId);
      }
    } else {
      emit(EditRequestFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  void _checkAllSelections({
    required String hallId,
    required String requestId,
    required String userId,
    required BuildContext context,
    required String reservationId,
    required String userToken,
  }) {
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
        emit(EditRequestLoading());
        bool conflictFound = false;

        FirebaseFirestore.instance
            .collection('locs')
            .doc(hallId)
            .collection('reservations')
            .get()
            .then((value) async {
          String? adminName = await SherdPrefHelper().getUserName();

          for (var element in value.docs) {
            Timestamp docStartTime = element.get('startTime');
            Timestamp docEndTime = element.get('endTime');
            String replayState = element.get('replyState');

            bool conflict = startDateTime.isBefore(docEndTime.toDate()) &&
                endDateTime.isAfter(docStartTime.toDate()) &&
                replayState != ReplyState.unaccepted.description;

            if (conflict) {
              conflictFound = true;
              emit(ThereWasConflict(
                  S.of(context).there_was_a_conflict_with_another_reservation));
              break;
            }
          }

          if (!conflictFound) {
            List<String> pathsToUpdate = [
              'locs/$hallId/reservations/$reservationId',
              'users/$userId/requests/$requestId',
            ];

            for (var path in pathsToUpdate) {
              await FirebaseFirestore.instance.doc(path).update({
                'modiferAdminToken': userToken,
                'modifiedDoc': reservationId,
                'replyState': ReplyState.modified.description,
                'modifer': adminName,
                'adminModified': true,
                'startTime': Timestamp.fromDate(startDateTime),
                'endTime': Timestamp.fromDate(endDateTime),
              });
            }
            PushNotificationService.sendNotificationToSelectedUser(
              deviceToken: userToken,
              screen: UserRequests.id,
              title: 'طلب تعديل',
              body: 'طلب تعديل طلبك من ${selectedStartTime!.format(context)} الى ${selectedEndTime!.format(context)}',
            );
            emit(EditRequestSuccess(
                '${S.of(context).you_have_updated_request_from} ${selectedStartTime!.format(context)} ${S.of(context).to} ${selectedEndTime!.format(context)} ${S.of(context).on} ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'));
          }
        });
      }
    }
  }
}
