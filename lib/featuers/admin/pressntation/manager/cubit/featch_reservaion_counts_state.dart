part of 'featch_reservaion_counts_cubit.dart';

@immutable
sealed class FeatchReservaionCountsState {}

final class FeatchReservaionCountsInitial extends FeatchReservaionCountsState {}

final class FeatchReservaionCountsLoading extends FeatchReservaionCountsState {}

final class FeatchReservaionCountsLoaded extends FeatchReservaionCountsState {
  final Map<String, int> reservationsCounts;
  FeatchReservaionCountsLoaded(this.reservationsCounts);
}

