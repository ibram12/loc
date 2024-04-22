import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

    Future<void> signUpWithEmailAndPassword(String email, String password, String name)async {
try {
  emit(SignUpLoading());
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  emit(SignUpSuccess());
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    emit(SignUpError('The password provided is too weak.'));
  } else if (e.code == 'email-already-in-use') {
    emit(SignUpError('The account already exists for that email.'));
  }
} catch (e) {
  emit(SignUpError('some thing went wrong, please try later'));
}
  }
}
