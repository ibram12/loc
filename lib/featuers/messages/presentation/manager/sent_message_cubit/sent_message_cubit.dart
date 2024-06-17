import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:meta/meta.dart';
import '../../../data/models/chat_buble_model.dart';

part 'sent_message_state.dart';

class SentMessageCubit extends Cubit<SentMessageState> {
  SentMessageCubit() : super(SentMessageInitial());

  Future<void> sentMessage({required String message}) async {
    String id = FirebaseAuth.instance.currentUser!.uid;

    // Add message locally with isSent set to false
    var myBox = Hive.box<ChatBubleModel>(kMessagesBox);
    ChatBubleModel newMessage = ChatBubleModel(
      id: id,
      massege: message,
      time: Timestamp.now(),
      isSent: false,
    );
    myBox.add(newMessage);

    emit(MessageSentLocalySuccess());

    emit(SentMessageLoading());

    // Send the message to Firestore
    await FirebaseFirestore.instance.collection('messages').add({
      "message": message,
      "time": DateTime.now(),
      "id": id,
      "isSent": true,
    });

    // Update the local Hive database to set the isSent flag to true for the last message
    var messages = myBox.values.toList();
    if (messages.isNotEmpty) {
      ChatBubleModel lastMessage = messages.reduce((current, next) =>
          current.time.seconds > next.time.seconds ? current : next);

      lastMessage.isSent = true;
      await lastMessage.save();
    }

    emit(SentMessageSuccess());
  }
}
