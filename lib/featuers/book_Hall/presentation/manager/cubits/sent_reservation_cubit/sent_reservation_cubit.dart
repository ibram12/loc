import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/server/shered_pref_helper.dart';
part 'sent_reservation_state.dart';

class SentReservationToAdminCubit extends Cubit<SentReservationState> {
  SentReservationToAdminCubit() : super(SentReservationInitial());
  Future<void> sentReservation({
    required Timestamp endTime,
    required Timestamp startTime,
    required DateTime data,
    required List<String> halls,
    required  Future<List<String>> requestIdsInUserCollection,
    required bool isDaily,
    required String selectedService
  }) async {
    String? getUserName = await SherdPrefHelper().getUserName();
  Future<String> getName()async{
  String name = await  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => value.data()!['name']);
  SherdPrefHelper().setUserName(name);
  return name;}
    bool? isAdmin = await SherdPrefHelper().getUserRole();

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
      List<String> requestIds = await requestIdsInUserCollection;
      for (int i = 0; i < halls.length; i++) {
               String requestId = requestIds[i];

        DocumentReference reservationRef =
            await DataBaseMethouds().addReservation(resrvationInfo, halls[i]);
           String? userImage = FirebaseAuth.instance.currentUser!.photoURL;


        await reservationRef.set({
          'hallId': halls[i],
          'daily': isDaily,
          'requestId': requestId,
          'id': FirebaseAuth.instance.currentUser!.uid,
          'name': getUserName?? await getName(),
          'startTime': startTime,
          'endTime': endTime,
          'date': '${data.day}/${data.month}/${data.year}',
          'replyState': isAdmin == true ? ReplyState.accepted.description : ReplyState.noReplyYet.description,
          'service':selectedService,
          'image':userImage
        });
      }
      emit(SentReservationSuccess());
    } catch (err) {
      emit(SentReservationError(err.toString()));
    }
  }
}
