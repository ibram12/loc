part of 'add_request_cubit.dart';

@immutable
sealed class AddRequestState {}

final class AddRequestInitial extends AddRequestState {}

final class AddRequestLoading extends AddRequestState {}

final class AddRequestSuccess extends AddRequestState {
}

final class AddRequestFailure extends AddRequestState {
  final String error;
  AddRequestFailure({required this.error});
}

