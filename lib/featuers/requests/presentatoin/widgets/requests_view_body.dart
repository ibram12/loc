import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/request_item.dart';

class UserRequestBody extends StatefulWidget {
  const UserRequestBody({
    super.key,
  });

  @override
  State<UserRequestBody> createState() => _UserRequestBodyState();
}

class _UserRequestBodyState extends State<UserRequestBody> {
  String id = FirebaseAuth.instance.currentUser!.uid;
  late Query query;
  late Stream<QuerySnapshot> requestsStream;
  // void checkOntheData(){
  //   if
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('requests')
        .orderBy('replyState', descending: true);
    requestsStream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
  stream: requestsStream,
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Something went wrong');
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else {
      // Get the current week's starting and ending timestamps
      DateTime now = DateTime.now();
      DateTime startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
      DateTime endOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 8);
       
      // Iterate over the documents to find the ones to delete
      List<DocumentSnapshot> documentsToDelete = [];
      snapshot.data!.docs.forEach((doc) {
        Timestamp startTime = doc.get('startTime');
        if (!isWithinCurrentWeek(startTime.toDate(), startOfWeek, endOfWeek)) {
          documentsToDelete.add(doc);
        }
      });

      // Delete the documents that are not within the current week
      documentsToDelete.forEach((doc) {
        doc.reference.delete();
      });

      // Render the remaining documents
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          return UserRequestItem(
            requestModel: UserRequestModel.fromDocumentSnapshot(snapshot.data!.docs[index]),
          );
        },
      );
    }
  },
);
  }
// Function to check if a date is within the current week
bool isWithinCurrentWeek(DateTime date, DateTime startOfWeek, DateTime endOfWeek) {
  return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
}
}