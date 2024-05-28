part of 'get_hall_requests_cubit.dart';

@immutable
sealed class GetHallRequestsState {}

final class GetHallRequestsInitial extends GetHallRequestsState {}

final class GetHallRequestsLoading extends GetHallRequestsState {}

final class GetHallRequestsSuccess extends GetHallRequestsState {
  final List<Map<String,dynamic>> requests;
  GetHallRequestsSuccess(this.requests);
}

final class GetHallRequestsError extends GetHallRequestsState {
  final String message;
  GetHallRequestsError(this.message);
}
