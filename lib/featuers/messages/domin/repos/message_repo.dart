import '../../data/models/chat_buble_model.dart';

abstract class MessageRepo{
  Future<List<ChatBubleModel>> getMessages();
}