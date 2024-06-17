import 'package:bloc/bloc.dart';
import 'package:loc/featuers/messages/domin/repos/message_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/chat_buble_model.dart';

part 'reed_messages_state.dart';

class ReedMessagesCubit extends Cubit<ReedMessagesState> {
  ReedMessagesCubit(this.messageRepo) : super(ReedMessagesInitial());
  final MessageRepo messageRepo;
  Future<void> getMessages() async {
    emit(ReedMessagesLoading());
    List<ChatBubleModel> messages = await messageRepo.getMessages();
    emit(ReedMessagesSuccess(messages: messages));
  }
}
