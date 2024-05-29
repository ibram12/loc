part of 'admin_reply_cubit.dart';

@immutable
sealed class AdminReplyState {}

final class AdminReplyInitial extends AdminReplyState {}

final class AdminReplyLoading extends AdminReplyState {}

final class AdminReplyAccept extends AdminReplyState {}

final class AdminReplyReject extends AdminReplyState {}   


