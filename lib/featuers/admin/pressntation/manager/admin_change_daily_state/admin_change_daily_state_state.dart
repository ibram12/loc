part of 'admin_change_daily_state_cubit.dart';

@immutable
sealed class AdminChangeDailyStateState {}

final class AdminChangeDailyStateInitial extends AdminChangeDailyStateState {}
final class AdminChangeDailyStateLoading extends AdminChangeDailyStateState{}
final class AdminChangeDailyStateToDaily extends AdminChangeDailyStateState{}
final class AdminChangeDailyStateToNotDaily extends AdminChangeDailyStateState{}
final class AdminChangeDailyStateFalier extends AdminChangeDailyStateState{}


