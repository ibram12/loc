import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:loc/core/notifications/get_user_token.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:meta/meta.dart';
import '../../../data/models/chat_buble_model.dart';

part 'sent_message_state.dart';

class SentMessageCubit extends Cubit<SentMessageState> {
  SentMessageCubit() : super(SentMessageInitial());

  Future<void> sentMessage({required String message}) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
     String? userName =await SherdPrefHelper().getUserName();
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

    await FirebaseFirestore.instance.collection('messages').add({
      "message": message,
      "time": DateTime.now(),
      "id": id,
      "isSent": true,
    });

    var messages = myBox.values.toList();
    if (messages.isNotEmpty) {
      ChatBubleModel lastMessage = messages.reduce((current, next) =>
          current.time.seconds > next.time.seconds ? current : next);

      lastMessage.isSent = true;
      await lastMessage.save();
    }
     PushNotificationService.sendNotificationToAllUsers(title: userName??'', body: message);
    emit(SentMessageSuccess());
  }
}
