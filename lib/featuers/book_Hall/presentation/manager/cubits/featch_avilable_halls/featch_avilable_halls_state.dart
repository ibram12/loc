part of 'featch_avilable_halls_cubit.dart';

@immutable
sealed class FeatchAvilableHallsState {}

final class FeatchAvilableHallsInitial extends FeatchAvilableHallsState {}

final class FeatchAvilableHallsLoading extends FeatchAvilableHallsState {}

final class FeatchAvilableHallsSuccess extends FeatchAvilableHallsState {
  final List<QueryDocumentSnapshot> docs;
  FeatchAvilableHallsSuccess({required this.docs});
}

final class FeatchAvilableHallsError extends FeatchAvilableHallsState {
  final String message;
  FeatchAvilableHallsError({required this.message});
}
