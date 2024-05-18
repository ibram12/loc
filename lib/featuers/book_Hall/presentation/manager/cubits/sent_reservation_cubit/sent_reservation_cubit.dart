import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    required Future< String >requestIdInUserCollection,
  }) async {
    String? getUserName = await SherdPrefHelper().getUserName();
  Future<String> getName()async{
  String name = await  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => value.data()!['name']);
  SherdPrefHelper().setUserName(name);
  return name;}

    Map<String, dynamic> resrvationInfo = {
      'id': FirebaseAuth.instance.currentUser!.uid,
      'name': getUserName,
      'startTime': startTime,
      'endTime': endTime,
      'date': '${data.day}/${data.month}/${data.year}',
      'replyState': ReplyState.noReplyYet.description,
    };
    try {
      emit(SentReservationLoading());
       String requestId = await requestIdInUserCollection;
      for (int i = 0; i < halls.length; i++) {
        DocumentReference reservationRef =
            await DataBaseMethouds().addReservation(resrvationInfo, halls[i]);
  

        await reservationRef.set({
          'daily':false,
          'requestId': requestId,
          'id': FirebaseAuth.instance.currentUser!.uid,
          'name': getUserName?? await getName(),
          'startTime': startTime,
          'endTime': endTime,
          'date': '${data.day}/${data.month}/${data.year}',
          'replyState': ReplyState.noReplyYet.description,
        });
      }
      emit(SentReservationSuccess());
    } catch (err) {
      emit(SentReservationError(err.toString()));
    }
  }
}
