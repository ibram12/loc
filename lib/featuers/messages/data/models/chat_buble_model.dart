import 'package:hive/hive.dart';
part 'chat_buble_model.g.dart';
@HiveType(typeId: 1)
class ChatBubleModel extends HiveObject {
  @HiveField(0)
  final String massege;
    @HiveField(1)

  final String id;
    @HiveField(2)

  final DateTime time;

  ChatBubleModel({required this.id ,required this.massege, required this.time});

  factory ChatBubleModel.fromJson(Map<String, dynamic> json) {
    return ChatBubleModel(
      id: json['id'],
      massege: json['massege'],
      time: DateTime.parse(json['time']),
    );
  }
}
