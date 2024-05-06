import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
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
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: requestsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return  UserRequestItem(
                  requestModel: UserRequestModel.fromDocumentSnapshot(
                    snapshot.data!.docs[index],
                  )
                );
              });
        });
  }
}
