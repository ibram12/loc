import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../../generated/l10n.dart';

part 'select_time_state.dart';

class SelectTimeCubit extends Cubit<SelectTimeState> {
  SelectTimeCubit() : super(SelectTimeInitial());

  DateTime? date;
  Timestamp? startTime;
  Timestamp? endTime;

  Future<void> selectStartTime(
      BuildContext context,) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      helpText: S.of(context).select_time_cubit_in_book_hall_feature_pick_the_start_time,
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
      // ignore: use_build_context_synchronously
      emit(SelectTimeFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  void selectEndTime(BuildContext context, 
    ) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      helpText: S.of(context).select_time_cubit_in_book_hall_feature_pick_the_end_time,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null) {
      final pickedEndDateTime = DateTime(date!.year, date!.month,
          date!.day, pickedEndTime.hour, pickedEndTime.minute);
      Timestamp pickedTimesTemp = Timestamp.fromDate(pickedEndDateTime);
      endTime = pickedTimesTemp;
      emit(SelectEndTimeSuccess(pickedTimesTemp));
      _checkOnUserChoices(context);
    }else{
      // ignore: use_build_context_synchronously
      emit(SelectTimeFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }


Future <  void> selectDate(
    BuildContext context,
  ) async {
    DateTime now = DateTime.now();
  

    final DateTime? pickedDate = await showDatePicker(
        helpText: S.of(context).select_time_cubit_in_book_hall_feature_pick_the_date,
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate:   DateTime(now.year, now.month + 2, now.day),
);
    if (pickedDate != null) {
      date = pickedDate;

      emit(SelectDateSuccess(pickedDate));
    } else {
      // ignore: use_build_context_synchronously
      emit(SelectTimeFailer(S.of(context).the_operation_has_been_cancelled));
    }
  }

  void _checkOnUserChoices(BuildContext context) {
    emit(Loading());
    if (date != null && startTime != null && endTime != null) {
      if(startTime!.toDate().isAfter(endTime!.toDate())) {
        emit(TheStartTimeAfterTheEndTimeError(S.of(context).the_start_time_is_after_the_end_time));
      }else if(startTime == endTime) {
        emit(TheEndTimeAsSameAsStartTimeError(S.of(context).the_start_time_cant_be_the_same_as_the_end_time));
      }else{
        emit(SelectTimeSuccess());
      }
    }
  }
}
