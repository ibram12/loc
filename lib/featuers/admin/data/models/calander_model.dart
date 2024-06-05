import 'package:cloud_firestore/cloud_firestore.dart';

class ClanderModel {
  final String name;
  final String service;
  final Timestamp startTime;
  final Timestamp endTime;
  ClanderModel(
      {required this.service ,required this.name, required this.startTime, required this.endTime});

  factory ClanderModel.fromDoucumentSnapShot(
      DocumentSnapshot documentSnapshot) {
    return ClanderModel(
        service: documentSnapshot['service'],
        name: documentSnapshot['name'],
        startTime: documentSnapshot['startTime'],
        endTime: documentSnapshot['endTime']);
  }
}
