part of 'featch_avilable_halls_cubit.dart';

@immutable
sealed class FeatchAvilableHallsState {}

final class FeatchAvilableHallsInitial extends FeatchAvilableHallsState {}

final class FeatchAvilableHallsLoading extends FeatchAvilableHallsState {}

final class FeatchAvilableHallsSuccess extends FeatchAvilableHallsState {
  final List<QueryDocumentSnapshot> availableHalls;
  FeatchAvilableHallsSuccess(this.availableHalls);
}

final class FeatchAvilableHallsError extends FeatchAvilableHallsState {
  final String message;
  FeatchAvilableHallsError({required this.message});
}
