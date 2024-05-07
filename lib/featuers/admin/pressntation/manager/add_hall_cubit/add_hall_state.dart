part of 'add_hall_cubit.dart';

@immutable
sealed class AddHallState {}

final class AddHallInitial extends AddHallState {}

final class AddHallLoading extends AddHallState {}

final class AddHallSuccess extends AddHallState {

}

final class AddHallError extends AddHallState {}
