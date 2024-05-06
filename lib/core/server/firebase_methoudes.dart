import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';

class DataBaseMethouds {
  Future addUserDetails(Map<String, dynamic> userData, String uId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userData);
  }

  Future<DocumentReference<Map<String, dynamic>>> addReservation(
      Map<String, dynamic> resrvationInfo, String hallId) async {
    return await FirebaseFirestore.instance
        .collection('locs')
        .doc(hallId)
        .collection('reservations')
        .add(resrvationInfo);
  }

  Future addHall(Map<String, dynamic> hallInfo) async {
    return await FirebaseFirestore.instance.collection('locs').add(hallInfo);
  }

  Future deleteLoc(String id) async {
    FirebaseFirestore.instance.collection('locs').doc(id).delete();
  }


}

