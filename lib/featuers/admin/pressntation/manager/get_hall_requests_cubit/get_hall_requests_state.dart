part of 'get_hall_requests_cubit.dart';

@immutable
sealed class GetHallRequestsState {}

final class GetHallRequestsInitial extends GetHallRequestsState {}

final class GetHallRequestsLoading extends GetHallRequestsState {}

final class GetHallRequestsSuccess extends GetHallRequestsState {}
