import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String sendDate;
  final Timestamp startTime;
  final Timestamp endTime;
  final String name;
  RequestModel({required this.sendDate, required this.startTime, required this.endTime, required this.name});
factory RequestModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return RequestModel(
        sendDate: documentSnapshot['date'],
        name: documentSnapshot['name'],
        startTime: documentSnapshot['startTime'],
        endTime: documentSnapshot['endTime']);
  }

}
