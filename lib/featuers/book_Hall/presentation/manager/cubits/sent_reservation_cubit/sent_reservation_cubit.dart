import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/server/shered_pref_helper.dart';

part 'sent_reservation_state.dart';

class SentReservationCubit extends Cubit<SentReservationState> {
  SentReservationCubit() : super(SentReservationInitial());
  Future<void> sentReservation({
    required Timestamp endTime,
    required Timestamp startTime,
    required DateTime data,
    required List<String> halls,
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
      for (int i = 0; i < halls.length; i++) {
        await DataBaseMethouds().addReservation(resrvationInfo, halls[i]);
        //await DataBaseMethouds().addReservationToUser();
      }
      emit(SentReservationSuccess());
    } catch (err) {
      emit(SentReservationError(err.toString()));
    }
  }
}
