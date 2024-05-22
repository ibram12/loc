import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/request_item.dart';

import '../manager/user_edit_request_cubit/user_editing_request_cubit.dart';

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
    return  StreamBuilder<QuerySnapshot>(
  stream: requestsStream,
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return const Text('Something went wrong');
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }else if(snapshot.data!.docs.isEmpty){
      return const Center(child: Text('No Requests Yet'),);
    } else {
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
          DateTime endOfWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
       
    if (now.weekday == DateTime.saturday) {
            List<DocumentSnapshot> documentsToDelete = [];
            snapshot.data!.docs.forEach((doc) {
              Timestamp startTime = doc.get('startTime');
              if (isWithinCurrentWeek(startTime.toDate(), startOfWeek, endOfWeek)) {
                documentsToDelete.add(doc);
              }
            });

            documentsToDelete.forEach((doc) {
              doc.reference.delete();
            });
          }
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
        return  BlocProvider(
            create: (context) => UserEditingRequestCubit(),
            child:  UserRequestItem(
            requestModel: UserRequestModel.fromDocumentSnapshot(snapshot.data!.docs[index]),
                      ),
            );
          
        },
      );
    }
  },
);
  }
// Function to check if a date is within the current week
bool isWithinCurrentWeek(DateTime date, DateTime startOfWeek, DateTime endOfWeek) {
    return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
           date.isBefore(endOfWeek.add(const Duration(days: 1)));
}
}