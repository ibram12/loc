import 'package:hive/hive.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/data/models/chat_buble_model.dart';

void saveMessagesData(List<ChatBubleModel> messages){
  var box1 = Hive.box<ChatBubleModel>(kMessagesBox);
  box1.addAll(messages);
}