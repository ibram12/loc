import 'package:cloud_firestore/cloud_firestore.dart';

class ClanderModel {
  final String name;
  final Timestamp startTime;
  final Timestamp endTime;
  ClanderModel(
      {required this.name, required this.startTime, required this.endTime});

  factory ClanderModel.fromDoucumentSnapShot(
      DocumentSnapshot documentSnapshot) {
    return ClanderModel(
        name: documentSnapshot['name'],
        startTime: documentSnapshot['startTime'],
        endTime: documentSnapshot['endTime']);
  }
}
