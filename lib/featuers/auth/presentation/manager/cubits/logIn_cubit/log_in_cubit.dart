import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/server/shered_pref_helper.dart';
import '../../../../../../generated/l10n.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  Future<void> logInWithEmailAndPassword(BuildContext context,String email, String password) async {
  try {
  emit(LogInLoading());
   await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
    String? userName;

  String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userInfo =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    userName = userInfo['name'];
    if (userName != null) {
      print('$userName==========================');
      await SherdPrefHelper().setUserName(userName);
    }
  emit(LogInSuccess());
} on FirebaseAuthException catch (e) {
  if (e.code == e.code) {
    emit(LogInError(S.of(context).login_cubit_messages_wrong_email_or_password));
  } 
}
  }
}
