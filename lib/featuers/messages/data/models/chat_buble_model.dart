import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'chat_buble_model.g.dart';

@HiveType(typeId: 1)
class ChatBubleModel extends HiveObject {
  @HiveField(0)
  final String massege;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final Timestamp time;
  @HiveField(3)
  bool isSent;
  @HiveField(4)
  String docId;

  ChatBubleModel(
      {required this.isSent,
      required this.id,
      required this.massege,
      required this.time,
      required this.docId
      });

  factory ChatBubleModel.fromJson(Map<String, dynamic> json,String docId) {
    return ChatBubleModel(
      docId: docId,
      isSent: json['isSent'],
      id: json['id'],
      massege: json['message'],
      time: json['time'],
    );
  }
}
