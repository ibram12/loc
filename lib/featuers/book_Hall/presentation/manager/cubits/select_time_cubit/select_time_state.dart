part of 'select_time_cubit.dart';

@immutable
sealed class SelectTimeState {}

final class SelectTimeInitial extends SelectTimeState {}

final class SelectStartTimeSuccess extends SelectTimeState {
  final Timestamp startTime;

  SelectStartTimeSuccess(this.startTime);
}

final class Loading extends SelectTimeState {}

final class SelectEndTimeSuccess extends SelectTimeState {
  final Timestamp endTime;

  SelectEndTimeSuccess(this.endTime);
}

final class SelectDateSuccess extends SelectTimeState {
  final DateTime date;

  SelectDateSuccess(this.date);
}

final class SelectTimeFailer extends SelectTimeState {
  final String message;

  SelectTimeFailer(this.message);
}

final class TheStartTimeAfterTheEndTimeError extends SelectTimeState {
  final String message;

  TheStartTimeAfterTheEndTimeError(this.message);
}

final class TheEndTimeAsSameAsStartTimeError extends SelectTimeState {
  final String message;

  TheEndTimeAsSameAsStartTimeError(this.message);
}

final class SelectTimeSuccess extends SelectTimeState {}
