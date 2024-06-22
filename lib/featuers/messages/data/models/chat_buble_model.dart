import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:loc/featuers/messages/data/models/sent_state_enum.dart';
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
  final String name;
  @HiveField(4)
  String docId;
  @HiveField(5)
  MessageStatus status;
  @HiveField(6)
  final String profileImage;

  ChatBubleModel(
      {required this.profileImage,
      required this.name,
      this.status = MessageStatus.sending,
      required this.id,
      required this.massege,
      required this.time,
      required this.docId});

  factory ChatBubleModel.fromJson(Map<String, dynamic> json, String docId) {
    return ChatBubleModel(
      profileImage: json['profileImage'],
      name: json['name'],
      docId: docId,
      id: json['id'],
      massege: json['message'],
      time: json['time'],
    );
  }
}
