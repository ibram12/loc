import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/firebase_methoudes.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String userpassword,
    required String role,
    required String service,
    required String name,
    required String adminPassword,
  }) async {
    emit(SignUpLoading());

    User? admin = FirebaseAuth.instance.currentUser;
    String? adminEmail = admin?.email;
    String? password = '';

    try {
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
      emit(SignUpLoading());
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
        'service': service,
      };
      emit(AdminEnterTruePassword());
      await DataBaseMethouds().addUserDetails(userInfo, credential.user!.uid);
      emit(UserAddedSuccess());

      await FirebaseAuth.instance.signOut();
      emit(SignUpLoading());

      if (adminEmail != null && password != '') {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: adminEmail,
          password: password!,
        );
      }

      emit(AdminBackToHisAccount());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpError('The account already exists for that email.'));
      } else {
        emit(SignUpError('Something went wrong, please try later.'));
      }
    } catch (e) {
      emit(SignUpError('Something went wrong, please try later.'));
    }
  }
}
