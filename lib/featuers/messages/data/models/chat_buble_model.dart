import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:loc/featuers/messages/data/models/sent_state_enum.dart';

class ChatBubleModel extends HiveObject {
  final String massege;
  final String id;
  final Timestamp time;
  final String name;
  String docId;
  MessageStatus status;
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
