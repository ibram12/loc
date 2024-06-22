 class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class UserAddedSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
class AdminEnterTruePassword extends SignUpState {}
class AdminEnterWrongPassword extends SignUpState {
  final String massage;
  AdminEnterWrongPassword(this.massage);
}

class AdminBackToHisAccount extends SignUpState {}
