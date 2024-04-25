import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/server/shered_pref_helper.dart';

part 'sent_reservation_state.dart';

class SentReservationCubit extends Cubit<SentReservationState> {
  SentReservationCubit() : super(SentReservationInitial());
  Future<void> sentReservation({required TimeOfDay startTime, required TimeOfDay endTime,
    required  DateTime data,required String hallId}) async {
      String? getUserName =await SherdPrefHelper().getUserName();
    Map<String, dynamic> resrvationInfo = {
      'name': getUserName,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'date': '${data.day}/${data.month}/${data.year}',
    };
    try {
      emit(SentReservationLoading());
      await DataBaseMethouds().addReservation(resrvationInfo, hallId);
      emit(SentReservationSuccess());
    } catch (err) {
      emit(SentReservationError(err.toString()));
      throw err;
    }
  }
}
