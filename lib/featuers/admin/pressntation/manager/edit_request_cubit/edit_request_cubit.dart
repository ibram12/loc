import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

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
      emit(EditTheDateSuccess(pickedDate));
    } else {
          emit(EditRequestFailer('The operation has been cancelled'));
    }
  }

  Future<void> selectStartTime(
    BuildContext context,
    Timestamp initialStartTime,
  ) async {
    int hour = initialStartTime.toDate().hour;
    int minute = initialStartTime.toDate().minute;
    final TimeOfDay? pickedStartTime = await showTimePicker(

      helpText: 'Edit start time',
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
      emit(EditRequestFailer('The operation has been cancelled'));
    }
  }

  void selectEndTime(BuildContext context, String hallId, String requestId,
      String userId, Timestamp initialEndTime) async {
    int hour = initialEndTime.toDate().hour;
    int minute = initialEndTime.toDate().minute;
    final TimeOfDay? pickedEndTime = await showTimePicker(
      helpText: 'Edit end time',
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
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
      emit(EditEndTimeSuccess(pickedEndTimeTemp));
      _checkAllSelections(
          hallId: hallId,
          requestId: requestId,
          userId: userId,
          context: context);
    } else {
      emit(EditRequestFailer('The operation has been cancelled'));
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
        emit(EditRequestLoading());
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
                if(conflict){
                  hasConflict = true;
                  emit(ThereWasConflict('There was a conflict with another reservation'));
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
          if (!canEdit) {
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