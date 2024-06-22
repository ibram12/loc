import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:loc/core/notifications/get_user_token.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:meta/meta.dart';

import '../../../data/models/chat_buble_model.dart';
import '../../../data/models/sent_state_enum.dart';

part 'sent_message_state.dart';

class SentMessageCubit extends Cubit<SentMessageState> {
  final Box<ChatBubleModel> chatBox;

  SentMessageCubit(this.chatBox) : super(SentMessageInitial()) {
    loadMessageStatuses();
  }

  void loadMessageStatuses() {
    final messages = chatBox.values.toList();
    final statuses = messages.map((m) => m.status).toList();
    emit(SentMessageState(messageStatuses: statuses));
  }

  Future<void> sendMessage({required String message}) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    String? userName = await SherdPrefHelper().getUserName();
    String? profileImage = FirebaseAuth.instance.currentUser!.photoURL;
    final chatMessage = ChatBubleModel(
      profileImage: profileImage??"",
      name: userName??"",
      id: id,
      massege: message,
      time: Timestamp.now(),
      docId: '', // Set docId later
      status: MessageStatus.sending,
    );
    chatBox.add(chatMessage);

    final updatedStatuses = List<MessageStatus>.from(state.messageStatuses)
      ..add(MessageStatus.sending);
    emit(SentMessageState(messageStatuses: updatedStatuses));

    final messageIndex = updatedStatuses.length - 1;

    try {
      final docRef = await FirebaseFirestore.instance.collection('messages').add({
        "name": userName,
        "profileImage": profileImage??"",
        "message": message,
        "time": chatMessage.time,
        "id": id,
      });

      await PushNotificationService.sendNotificationToAllUsers(
          title: userName ?? '', body: message);

      chatMessage.status = MessageStatus.sent;
      chatMessage.docId = docRef.id;
      chatMessage.save();

      updatedStatuses[messageIndex] = MessageStatus.sent;
      emit(SentMessageState(messageStatuses: updatedStatuses));
    } catch (e) {
      chatMessage.status = MessageStatus.error;
      chatMessage.save();

      updatedStatuses[messageIndex] = MessageStatus.error;
      emit(SentMessageState(messageStatuses: updatedStatuses));
    }
  }
}