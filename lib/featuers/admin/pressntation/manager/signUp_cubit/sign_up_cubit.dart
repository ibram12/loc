import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/generated/l10n.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String userpassword,
    required String role,
    required List<String> services,
    required String name,
    required String adminPassword,
    required BuildContext context
  }) async {
    User? admin = FirebaseAuth.instance.currentUser;
    String? adminEmail = admin!.email;
    String? password = '';

    try {
      emit(SignUpLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminEmail!,
        password: adminPassword,
      );
      password = adminPassword;
      
    } on FirebaseAuthException catch (e) {
      if (e.code == e.code) {
        emit(AdminEnterWrongPassword('Wrong Password'));
        return;
      }
    }
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: userpassword,
      );
      Map<String, dynamic> userInfo = {
        'email': email,
        'name': name,
        'id': credential.user!.uid,
        'role': role,
        'service': services,
        'image': '',
        'fcmToken': '',
        
      };
      emit(AdminEnterTruePassword());
      await DataBaseMethouds().addUserDetails(userInfo, credential.user!.uid);
      emit(UserAddedSuccess());

      await FirebaseAuth.instance.signOut();

      if (adminEmail != null && password != '') {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: adminEmail,
          password: password!,
        );
      }

      emit(AdminBackToHisAccount());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpError(S.of(context).the_password_provided_is_too_weak));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpError(S.of(context).the_account_already_exists_for_that_email));
      } else {
        emit(SignUpError(S.of(context).something_went_wrong_please_try_later));
      }
    } catch (e) {
      emit(SignUpError(S.of(context).something_went_wrong_please_try_later));
    }
  }
}
