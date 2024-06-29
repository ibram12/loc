import 'package:cloud_firestore/cloud_firestore.dart';

class ReservatoinModel {
  final String serviceName;
  final Timestamp startTime;
  final Timestamp endTime;
  final String userName;
  ReservatoinModel( 
      {required this.serviceName,
      required this.startTime,
      required this.endTime,
      required this.userName});

  factory ReservatoinModel.fromDoucumentSnapshot(Map<String, dynamic> doc) {
    return ReservatoinModel(
        userName: doc['name'],
        serviceName: doc['service'],
        startTime: doc['startTime'],
        endTime: doc['endTime']);
  }
}
