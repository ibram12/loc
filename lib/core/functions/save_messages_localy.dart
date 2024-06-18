import 'package:hive/hive.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/data/models/chat_buble_model.dart';

void saveMessagesData(List<ChatBubleModel> messages){
  var box = Hive.box<ChatBubleModel>(kMessagesBox);
  box.addAll(messages);
}