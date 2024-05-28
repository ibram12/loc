part of 'user_editing_request_cubit.dart';

@immutable
sealed class UserEditingRequestState {}

final class UserEditingRequestInitial extends UserEditingRequestState {}

class UserEditingRequestLoading extends UserEditingRequestState {}

class UserSelectTheDateSuccess extends UserEditingRequestState {
  final DateTime dateTime;

  UserSelectTheDateSuccess(this.dateTime);
}

class UserSelectStartTimeSuccess extends UserEditingRequestState {
  final Timestamp startTime;
  UserSelectStartTimeSuccess(this.startTime);
}

class UserSelectEndTimeSuccess extends UserEditingRequestState {
  final Timestamp endTime;
  UserSelectEndTimeSuccess(this.endTime);
}

class UserUptadingRequestSuccess extends UserEditingRequestState {
  final String successMessage;

  UserUptadingRequestSuccess(this.successMessage);
}

class TheStartTimeIsAfterTheEndTime extends UserEditingRequestState {
  final String errMassege;
  TheStartTimeIsAfterTheEndTime(this.errMassege);
}

class TheStartTImeTheSameAsTheEndTime extends UserEditingRequestState {
  final String errMassege;
  TheStartTImeTheSameAsTheEndTime(this.errMassege);
}

class UserEditingRequestFailer extends UserEditingRequestState {
  final String message;
  UserEditingRequestFailer(this.message);
}
class ThereWasConflict extends UserEditingRequestState {
  final String message;
  ThereWasConflict(this.message);
}
