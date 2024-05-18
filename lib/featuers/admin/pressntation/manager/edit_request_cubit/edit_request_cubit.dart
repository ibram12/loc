import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'edit_request_state.dart';

class EditRequestCubit extends Cubit<EditRequestState> {
  EditRequestCubit() : super(EditRequestInitial());
  Future<void> selectStartTime(
      BuildContext context,
      DateTime date,
      String hallId,
      String reservatoinId,
      String userId,
      String requestId,
      Timestamp initialStartTime) async {
    int hour = initialStartTime.toDate().hour;
    int minute = initialStartTime.toDate().minute;
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      helpText: 'Edit start time',
    );
    if (pickedStartTime != null) {
      // onselected(pickedStartTime);
      final pickedDateTime = DateTime(date.year, date.month, date.day,
          pickedStartTime.hour, pickedStartTime.minute);
      Timestamp pickedTimesTemp = Timestamp.fromDate(pickedDateTime);
      List<String> pathsToUpdate = [
        'locs/$hallId/reservations/$reservatoinId',
        'users/$userId/requests/$requestId',
      ];

      for (String path in pathsToUpdate) {
        await FirebaseFirestore.instance
            .doc(path)
            .update({'startTime': pickedTimesTemp});
        break;
      }
      emit(EditStartTImeSuccess(pickedTimesTemp));
    }
  }

  void selectEndTime(
      BuildContext context,
      DateTime selectedDate,
      String hallId,
      String reservatoinId,
      String userId,
      String requestId,
      Timestamp initialEndTime) async {
    int hour = initialEndTime.toDate().hour;
    int minute = initialEndTime.toDate().minute;
    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      helpText: 'Edit end time',
    );
    if (pickedEndTime != null) {
      // onselected(pickedEndTime);
      final pickedEndDateTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, pickedEndTime.hour, pickedEndTime.minute);
      Timestamp pickedTimesTemp = Timestamp.fromDate(pickedEndDateTime);
      List<String> pathsToUpdate = [
        'locs/$hallId/reservations/$reservatoinId',
        'users/$userId/requests/$requestId',
      ];
      for (var path in pathsToUpdate) {
        await FirebaseFirestore.instance
            .doc(path)
            .update({'endTime': pickedTimesTemp});
        break;
      }
      emit(EditEndTimeSuccess(pickedTimesTemp));
    }
  }
}
