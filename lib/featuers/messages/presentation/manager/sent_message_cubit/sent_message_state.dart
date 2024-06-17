part of 'sent_message_cubit.dart';

@immutable
sealed class SentMessageState {}

final class SentMessageInitial extends SentMessageState {}

final class SentMessageLoading extends SentMessageState {}

final class SentMessageSuccess extends SentMessageState {}

final class SentMessageError extends SentMessageState {
  final String error;
  SentMessageError({required this.error});
}
final class MessageSentLocalySuccess extends SentMessageState {}

final class MessageSentRemoteSuccess extends SentMessageState {}
