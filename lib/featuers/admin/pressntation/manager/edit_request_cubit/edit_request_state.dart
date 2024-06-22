part of 'edit_request_cubit.dart';

@immutable
sealed class EditRequestState {}

final class EditRequestInitial extends EditRequestState {}

class EditRequestLoading extends EditRequestState {}

class EditTheDateSuccess extends EditRequestState {
  final DateTime dateTime;

  EditTheDateSuccess(this.dateTime);
}

class EditStartTimeSuccess extends EditRequestState {
  final Timestamp startTime;
  EditStartTimeSuccess(this.startTime);
}

class EditEndTimeSuccess extends EditRequestState {
  final Timestamp endTime;
  EditEndTimeSuccess(this.endTime);
}

class EditRequestSuccess extends EditRequestState {
  final String successMessage;

  EditRequestSuccess(this.successMessage);
}

class TheStartTimeIsAfterTheEndTime extends EditRequestState {
  final String errMassege;
  TheStartTimeIsAfterTheEndTime(this.errMassege);
}

class TheStartTImeTheSameAsTheEndTime extends EditRequestState {
  final String errMassege;
  TheStartTImeTheSameAsTheEndTime(this.errMassege);
}

class EditRequestFailer extends EditRequestState {
  final String message;
  EditRequestFailer(this.message);
}
class ThereWasConflict extends EditRequestState {
  final String message;
  ThereWasConflict(this.message);
}
