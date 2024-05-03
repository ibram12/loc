import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'select_time_state.dart';

class SelectTimeCubit extends Cubit<SelectTimeState> {
  SelectTimeCubit() : super(SelectTimeInitial());
  Future<void> selectStartTime(
      BuildContext context,DateTime date,void Function(TimeOfDay) onselected) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      onselected(pickedStartTime);
      final pickedDateTime = DateTime(date.year, date.month, date.day,
          pickedStartTime.hour, pickedStartTime.minute);
          Timestamp pickedTimesTemp = Timestamp.fromDate(pickedDateTime);
      emit(SelectStartTimeSuccess(pickedTimesTemp));
    }
  }

  void selectEndTime(
      BuildContext context, DateTime selectedDate,void Function(TimeOfDay) onselected) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null) {
      onselected(pickedEndTime);
      final pickedEndDateTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, pickedEndTime.hour, pickedEndTime.minute);
          Timestamp pickedTimesTemp = Timestamp.fromDate(pickedEndDateTime);
      emit(SelectEndTimeSuccess(pickedTimesTemp));
    }
  }

  void selectDate(BuildContext context, DateTime? date) async {
    int cruntYear = DateTime.now().year;
    DateTime lastDate = DateTime(cruntYear + 1);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: lastDate,
    );
    if (pickedDate != null && pickedDate != date) {
      emit(SelectDateSuccess(pickedDate));
    }
  }
}
