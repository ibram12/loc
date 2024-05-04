import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/request_model.dart';
import 'request_item.dart';

class RequestsViewBody extends StatefulWidget {
  const RequestsViewBody({super.key, required this.hallId, required this.onNumberOfDocsChanged});
  final String hallId;

  final void Function(int) onNumberOfDocsChanged;

  @override
  State<RequestsViewBody> createState() => _RequestsViewBodyState();
}

class _RequestsViewBodyState extends State<RequestsViewBody> {
  late CollectionReference reservations;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reservations = FirebaseFirestore.instance
      .collection('locs')
      .doc(widget.hallId)
      .collection('reservations');
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: reservations.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
            widget.onNumberOfDocsChanged(snapshot.data?.docs.length ?? 0);
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return RequestItem(
                  requestModel: RequestModel.fromDocumentSnapshot(
                      snapshot.data!.docs[index]),
                );
              });
        });
  }
}
