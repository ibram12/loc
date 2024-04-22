import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthError {
  final String message;
  AuthError(this.message);
}

class ServerError extends AuthError {
  ServerError(super.message);

  factory ServerError.fromFireBaseAuthException(FirebaseAuthException ex) {
    switch (ex.code){
    case 'account-exists-with-different-credential':
      return ServerError('The account already exists with a different credential.');
    case 'invalid-credential':
      return ServerError('The credential is invalid.');
    case 'operation-not-allowed':
      return ServerError('Password sign-in is disabled for this project.');
      default : return ServerError(ex.message??'something went wrong, please try later');

    }
  }
}
