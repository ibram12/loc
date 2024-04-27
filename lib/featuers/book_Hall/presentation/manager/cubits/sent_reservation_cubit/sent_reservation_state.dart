part of 'sent_reservation_cubit.dart';

@immutable
sealed class GetFilteringDataState {}

final class SentReservationInitial extends GetFilteringDataState {}

final class GetFilteringDataSuccess extends GetFilteringDataState {}
final class GetFilteringDataLoading extends GetFilteringDataState {}

final class GetFilteringDataError extends GetFilteringDataState {
   final String message;

  GetFilteringDataError(this.message);

}
