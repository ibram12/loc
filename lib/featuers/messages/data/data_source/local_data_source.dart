import 'package:hive/hive.dart';

import '../../../../core/utils/constants.dart';
import '../models/chat_buble_model.dart';

abstract class MessagesLocalDataSource {
  List<ChatBubleModel> getMessages();
}

class MessagesLocalDataSourceImpl implements MessagesLocalDataSource {
  @override
  List<ChatBubleModel> getMessages()  {

    var myBox = Hive.box(kMessagesBox);

    if (myBox.isNotEmpty) {
      return myBox.values.toList().cast<ChatBubleModel>();
    }
    return [];
  }
}