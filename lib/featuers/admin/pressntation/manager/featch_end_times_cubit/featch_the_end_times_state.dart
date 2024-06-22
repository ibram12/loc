part of 'featch_the_end_times_cubit.dart';

@immutable
abstract class FeatchTheEndTimesState {}

class FeatchTheEndTimesInitial extends FeatchTheEndTimesState {}

class FeathTheEndTimesLoading extends FeatchTheEndTimesState {}

class ThereWasReservationInTheCruntTime extends FeatchTheEndTimesState {
  final String hallId;
  final Duration remainingTime;

  ThereWasReservationInTheCruntTime(this.hallId, this.remainingTime);
}

class NoReservationInTheCruntTime extends FeatchTheEndTimesState {
  final String hallId;

  NoReservationInTheCruntTime(this.hallId);
}

class FeatchTheEndTimesFailer extends FeatchTheEndTimesState {
  final String error;

  FeatchTheEndTimesFailer(this.error);
}
class FeatchEndTimesIsDone extends FeatchTheEndTimesState{}
