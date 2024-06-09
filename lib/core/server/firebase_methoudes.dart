import 'package:cloud_firestore/cloud_firestore.dart';

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
    await FirebaseFirestore.instance.collection('locs').doc(id).delete();
  }

  Future<void> deleteMyRequest(
      String userId, String requestId, String hallId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('requests')
        .doc(requestId)
        .delete()
        .then((value) async {
      QuerySnapshot reservations = await FirebaseFirestore.instance
          .collection('locs')
          .doc(hallId)
          .collection('reservations')
          .get();

      for (var element in reservations.docs) {
        String docrRequestId = element.get('requestId');
        if (docrRequestId == requestId) {
          element.reference.delete();
        }
      }
    });
  }

  Future<void> deleteRequestFromAdminPanel(
      {required String userId,
      required String requestId,
      required String hallId,
      required String requestIdInReservation}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('requests')
        .doc(requestId)
        .delete()
        .then((value) async {
              await FirebaseFirestore.instance
          .collection('locs')
          .doc(hallId)
          .collection('reservations')
          .doc(requestIdInReservation)
          .delete();
    });
  }
}
