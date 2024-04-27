import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';

import 'hall_item.dart';

class HallsListView extends StatefulWidget {
  const HallsListView({super.key});
  @override
  State<HallsListView> createState() => _HallsListViewState();
}

class _HallsListViewState extends State<HallsListView> {
  final Stream<QuerySnapshot> _hallsStream =
      FirebaseFirestore.instance.collection('locs').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: _hallsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return  HallItem(
                hallId: snapshot.data!.docs[index].id,
                hallModel: HallModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>),
              );
            });
      }
    );
  }
}
