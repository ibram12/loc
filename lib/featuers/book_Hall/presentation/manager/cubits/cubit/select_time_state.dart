part of 'select_time_cubit.dart';

@immutable
sealed class SelectTimeState {}

final class SelectTimeInitial extends SelectTimeState {}

final class SelectStartTimeSuccess extends SelectTimeState {
  final TimeOfDay startTime;

  SelectStartTimeSuccess(this.startTime);

}

final class SelectEndTimeSuccess extends SelectTimeState {
  final TimeOfDay endTime;

  SelectEndTimeSuccess(this.endTime);
}

final class SelectDateSuccess extends SelectTimeState {
  final DateTime date;

  SelectDateSuccess(this.date);

}

