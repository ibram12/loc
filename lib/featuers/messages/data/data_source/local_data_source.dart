import 'package:hive/hive.dart';

import '../../../../core/utils/constants.dart';
import '../models/chat_buble_model.dart';

abstract class MessagesLocalDataSource {
  Future<List<ChatBubleModel>> getMessages();
}

class MessagesLocalDataSourceImpl implements MessagesLocalDataSource {
  @override
  Future<List<ChatBubleModel>> getMessages() async {

    var myBox =await Hive.openBox(kMessagesBox);

    if (myBox.isNotEmpty) {
      return myBox.values.toList().cast<ChatBubleModel>();
    }
    return [];
  }
}