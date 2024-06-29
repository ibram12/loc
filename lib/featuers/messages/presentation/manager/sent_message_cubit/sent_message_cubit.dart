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

  SentMessageCubit(this.chatBox) : super(SentMessageInitial());

  Future<void> sendMessage({required String message}) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    String? userName = await SherdPrefHelper().getUserName();
    String? profileImage = FirebaseAuth.instance.currentUser!.photoURL;
  

    try {

          await FirebaseFirestore.instance.collection('messages').add({
        "name": userName,
        "profileImage": profileImage ?? "",
        "message": message,
        "time": Timestamp.now(),
        "id": id,
      });

      await PushNotificationService.sendNotificationToAllUsers(
          title: userName ?? '', body: message);

      
    } catch (e) {
            emit(const SentMessageState(messageStatuses: [MessageStatus.error]));
    }
  }
}
