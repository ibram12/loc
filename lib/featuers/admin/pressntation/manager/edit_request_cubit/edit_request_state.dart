part of 'edit_request_cubit.dart';

@immutable
sealed class EditRequestState {}

final class EditRequestInitial extends EditRequestState {}
final class EditRequestLoading extends EditRequestState {}

final class EditStartTImeSuccess extends EditRequestState {
  final Timestamp startTime;
  EditStartTImeSuccess(this.startTime);
}
final class EditEndTimeSuccess extends EditRequestState {
  final Timestamp endTime;
  EditEndTimeSuccess(this.endTime);
}
