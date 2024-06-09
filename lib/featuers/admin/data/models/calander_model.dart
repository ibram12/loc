import 'package:cloud_firestore/cloud_firestore.dart';

class ClanderModel {
  final String name;
  final String service;
  final Timestamp startTime;
  final Timestamp endTime;
  final String userId;
  final String requestId;
  final String hallId;
  ClanderModel(
      {
      required this.userId, required this.requestId, required this.hallId,required this.service,
      required this.name,
      required this.startTime,
      required this.endTime});

  factory ClanderModel.fromDoucumentSnapShot(
      DocumentSnapshot documentSnapshot) {
    return ClanderModel(
        hallId: documentSnapshot['hallId'],
      requestId: documentSnapshot['requestId'],
        userId: documentSnapshot['id'],
        service: documentSnapshot['service'],
        name: documentSnapshot['name'],
        startTime: documentSnapshot['startTime'],
        endTime: documentSnapshot['endTime']);
  }
}
