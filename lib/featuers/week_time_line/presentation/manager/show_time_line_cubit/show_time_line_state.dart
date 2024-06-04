part of 'show_time_line_cubit.dart';

@immutable
sealed class ShowTimeLineState {}

final class ShowTimeLineInitial extends ShowTimeLineState {}

final class ShowTimeLineLoading extends ShowTimeLineState {}

final class ShowTimeLineSuccess extends ShowTimeLineState {
  final List<Meeting> reservations;
  ShowTimeLineSuccess(this.reservations);
}

final class ShowTimeLineError extends ShowTimeLineState {
  final String error;

  ShowTimeLineError(this.error);
}
