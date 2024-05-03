import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/request_model.dart';
import 'request_item.dart';

class RequestsViewBody extends StatefulWidget {
  const RequestsViewBody({super.key});

  @override
  State<RequestsViewBody> createState() => _RequestsViewBodyState();
}

class _RequestsViewBodyState extends State<RequestsViewBody> {
  CollectionReference reservations = FirebaseFirestore.instance
      .collection('locs')
      .doc('3Bw9aH34obmcSnnPtWSO')
      .collection('reservations');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: reservations.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return RequestItem(
                  requestModel: RequestModel.fromDocumentSnapshot(
                      snapshot.data!.docs[index] ),
                );
              });
        });
  }
}
