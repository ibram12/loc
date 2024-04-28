import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/server/shered_pref_helper.dart';

part 'sent_reservation_state.dart';

class SentReservationCubit extends Cubit<SentReservationState> {
  SentReservationCubit() : super(SentReservationInitial());
  Future<void> sentReservation({
    required Timestamp endTime,
    required Timestamp startTime,
    required DateTime data,
  }) async {
    String? getUserName = await SherdPrefHelper().getUserName();
    Map<String, dynamic> resrvationInfo = {
      'name': getUserName,
      'startTime': startTime,
      'endTime': endTime,
      'date': '${data.day}/${data.month}/${data.year}',
    };
    try {
      emit(SentReservationLoading());
        await DataBaseMethouds().getAvilableHalls(resrvationInfo,'3Bw9aH34obmcSnnPtWSO');
      emit(SentReservationSuccess());
    } catch (err) {
      emit(SentReservationError(err.toString()));
    }
  }
}
