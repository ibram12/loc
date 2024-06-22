import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/server/shered_pref_helper.dart';
import '../../../../../../generated/l10n.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());

  Future<void> logInWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      emit(LogInLoading());
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userInfo = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String? userName = userInfo['name'];

      if (userName != null) {
        await SherdPrefHelper().setUserName(userName);
      }

      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      String? fcmToken = await messaging.getToken();

      if (fcmToken != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'fcmToken': fcmToken,
        });
        FirebaseMessaging.instance.subscribeToTopic(kTopic);

      }

      emit(LogInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        emit(LogInError(S.of(context).login_cubit_messages_wrong_email_or_password));
      } else {
        emit(LogInError('Login failed: ${e.message}'));
      }
    } catch (e) {
      emit(LogInError('Unexpected error: $e'));
    }
  }
}
