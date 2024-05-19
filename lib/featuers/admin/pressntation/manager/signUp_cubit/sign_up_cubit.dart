import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/firebase_methoudes.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String role,
      required String service,
      required String name}) async {
    try {
      emit(SignUpLoading());
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Map<String, dynamic> userInfo = {
        'email': email,
        'name': name,
        'id': credential.user!.uid,
        'role': role,
        'service': service
      };
      await DataBaseMethouds().addUserDetails(userInfo, credential.user!.uid);
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpError('The account already exists for that email.'));
      } else {
        emit(SignUpError('some thing went wrong, please try later'));
      }
    } on Exception catch (e) {
      emit(SignUpError('some thing went wrong, please try later'));
    }
  }
}
