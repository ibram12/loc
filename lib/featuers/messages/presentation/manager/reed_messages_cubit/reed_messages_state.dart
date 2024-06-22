part of 'reed_messages_cubit.dart';

@immutable
sealed class ReedMessagesState {}

final class ReedMessagesInitial extends ReedMessagesState {}

final class ReedMessagesLoading extends ReedMessagesState {}

final class ReedMessagesSuccess extends ReedMessagesState {


}
