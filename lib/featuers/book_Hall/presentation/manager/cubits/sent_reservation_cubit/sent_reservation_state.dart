part of 'sent_reservation_cubit.dart';

@immutable
sealed class SentReservationState {}

final class SentReservationInitial extends SentReservationState {}

final class SentReservationSuccess extends SentReservationState {}
final class SentReservationLoading extends SentReservationState {}

final class SentReservationError extends SentReservationState {
   final String message;

  SentReservationError(this.message);

}
