import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/notifications/get_user_token.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/server/shered_pref_helper.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../admin/pressntation/view/admin_view.dart';
part 'sent_reservation_state.dart';

class SentReservationToAdminCubit extends Cubit<SentReservationState> {
  SentReservationToAdminCubit() : super(SentReservationInitial());
  Future<void> sentReservation(
      {required Timestamp endTime,
      required List<String> hallNames,
      required Timestamp startTime,
      required DateTime data,
      required List<String> halls,
      required Future<List<String>> requestIdsInUserCollection,
      required bool isDaily,
      required String selectedService}) async {
    String? getUserName = await SherdPrefHelper().getUserName();
    Future<String> getName() async {
      String name = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) => value.data()!['name']);
      SherdPrefHelper().setUserName(name);
      return name;
    }

    DocumentSnapshot userInfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    String? fcmToken = userInfo['fcmToken'];
    String? isAdmin = await SherdPrefHelper().getUserRole();
    bool isSent = false;
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

        if (fcmToken != null) {
          await reservationRef.set({
            'fcmToken': fcmToken,
            'hallId': halls[i],
            'daily': isDaily,
            'requestId': requestId,
            'id': FirebaseAuth.instance.currentUser!.uid,
            'name': getUserName ?? await getName(),
            'startTime': startTime,
            'endTime': endTime,
            'date': '${data.day}/${data.month}/${data.year}',
            'replyState': isAdmin == kRoles[2]
                ? ReplyState.accepted.description
                : ReplyState.noReplyYet.description,
            'service': selectedService,
            'image': userImage
          });
        }
        if (isAdmin==kRoles[2]&&!isSent) {
  sentNotificationForAdmins(getUserName ?? await getName(),
      'request to book ${hallNames.join(', ')}\non ${data.day}/${data.month}/${data.year} at ${DateFormat('hh:mm a').format(startTime.toDate())} to ${DateFormat('hh:mm a').format(endTime.toDate())}');
isSent = true;
}
      }
      
        emit(SentReservationSuccess());
    } catch (err) {
      emit(SentReservationError(err.toString()));
    }
  }

  Future<void> sentNotificationForAdmins(String name, String body) async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var doc in value.docs) {
        if (doc['role'] == 'Admin') {
          PushNotificationService.sendNotificationToSelectedUser(
              screen: AdminView.id,
              deviceToken: doc['fcmToken'],
              title: 'requsest from $name',
              body: body);
        }
      }
    });
  }
}
