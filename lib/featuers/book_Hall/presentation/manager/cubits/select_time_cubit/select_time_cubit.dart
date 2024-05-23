import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'select_time_state.dart';

class SelectTimeCubit extends Cubit<SelectTimeState> {
  SelectTimeCubit() : super(SelectTimeInitial());

  DateTime? date;
  Timestamp? startTime;
  Timestamp? endTime;

  Future<void> selectStartTime(
      BuildContext context,) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      helpText: 'Pick the start time',
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      final pickedDateTime = DateTime(date!.year, date!.month, date!.day,
          pickedStartTime.hour, pickedStartTime.minute);
      Timestamp pickedTimesTemp = Timestamp.fromDate(pickedDateTime);
      startTime = pickedTimesTemp;
      emit(SelectStartTimeSuccess(pickedTimesTemp));
    } else {
      emit(SelectTimeFailer('The operation has been cancelled'));
    }
  }

  void selectEndTime(BuildContext context, 
    ) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      helpText: 'Pick the end time',
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null) {
      final pickedEndDateTime = DateTime(date!.year, date!.month,
          date!.day, pickedEndTime.hour, pickedEndTime.minute);
      Timestamp pickedTimesTemp = Timestamp.fromDate(pickedEndDateTime);
      endTime = pickedTimesTemp;
      emit(SelectEndTimeSuccess(pickedTimesTemp));
      _checkOnUserChoices();
    }else{
      emit(SelectTimeFailer('The operation has been cancelled'));
    }
  }

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
        lastDate: nextFriday);
    if (pickedDate != null) {
      date = pickedDate;
      emit(SelectDateSuccess(pickedDate));
    } else {
      emit(SelectTimeFailer('The operation has been cancelled'));
    }
  }

  void _checkOnUserChoices() {
    emit(Loading());
    if (date != null && startTime != null && endTime != null) {
      if(startTime!.toDate().isAfter(endTime!.toDate())) {
        emit(TheStartTimeAfterTheEndTimeError('The start time can\'t be after the end time'));
      }else if(startTime == endTime) {
        emit(TheEndTimeAsSameAsStartTimeError('The end time can\'t be the same as the start time'));
      }else{
        emit(SelectTimeSuccess());
      }
    }
  }
}
