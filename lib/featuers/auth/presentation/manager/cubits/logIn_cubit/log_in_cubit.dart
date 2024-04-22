import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      emit(LogInLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LogInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LogInError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LogInError('Wrong password provided for that user.'));
      }
    }
  }
}
