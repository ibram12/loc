part of 'featch_avilable_halls_cubit.dart';

@immutable
sealed class FeatchAvilableHallsState {}

final class FeatchAvilableHallsInitial extends FeatchAvilableHallsState {}

final class ThereNoAvilableHalls extends FeatchAvilableHallsState {}

final class FeatchAvilableHallsLoaded extends FeatchAvilableHallsState {
  final List<String> availableHalls;
  FeatchAvilableHallsLoaded(this.availableHalls);
}

final class FeatchAvilableHallsError extends FeatchAvilableHallsState {
  final String message;
  FeatchAvilableHallsError({required this.message});
}
