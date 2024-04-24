import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'select_time_state.dart';

class SelectTimeCubit extends Cubit<SelectTimeState> {
  SelectTimeCubit() : super(SelectTimeInitial());
  Future<void> selectStartTime(
      BuildContext context, TimeOfDay? startTime) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null && pickedStartTime != startTime) {

      emit(SelectStartTimeSuccess(pickedStartTime));
    }
  }

  void selectEndTime(BuildContext context, TimeOfDay? endTime) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null && pickedEndTime != endTime) {
      emit(SelectEndTimeSuccess(pickedEndTime));
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
