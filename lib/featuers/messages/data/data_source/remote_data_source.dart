import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loc/core/functions/save_messages_localy.dart';

import '../models/chat_buble_model.dart';

abstract class MessagesRemoteDataSource {
  Future<List<ChatBubleModel>> getMessages();
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  @override
  Future<List<ChatBubleModel>> getMessages() async {
   QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection("messages").orderBy('time').get();
  List<ChatBubleModel> messagesList =  getList(querySnapshot);
   saveMessagesData(messagesList);
    return messagesList;
  }

  List<ChatBubleModel> getList(QuerySnapshot data) {
    List<ChatBubleModel> messagesList = [];

    for (var message in data.docs) {
      messagesList.add(ChatBubleModel.fromJson(message.data() as Map<String, dynamic>,message.id));
    }
    return messagesList;
  }
}
