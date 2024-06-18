part of 'sent_message_cubit.dart';

@immutable
 class SentMessageState {
  final List<MessageStatus> messageStatuses;

const  SentMessageState({required this.messageStatuses});
}

class SentMessageInitial extends SentMessageState {
  SentMessageInitial() : super(messageStatuses: []);
}
