part of 'check_on_hall_requests_cubit.dart';

@immutable
sealed class CheckOnRequestsState {}

final class CheckOnRequestsInitial extends CheckOnRequestsState {}

final class CheckOnRequestsLoading extends CheckOnRequestsState {}

final class CheckOnRequestsSuccess extends CheckOnRequestsState {

}

final class CheckOnRequestsError extends CheckOnRequestsState {
  final String message;
  CheckOnRequestsError(this.message);
}
