import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/helper/delete_alert_dialog.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/featuers/admin/pressntation/widgets/admin_hall_item.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';

class AllHallsListView extends StatefulWidget {
  const AllHallsListView({super.key});

  @override
  State<AllHallsListView> createState() => _AllHallsListViewState();
}

class _AllHallsListViewState extends State<AllHallsListView> {
  final Stream<QuerySnapshot> _hallsStream =
      FirebaseFirestore.instance.collection('locs').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: _hallsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return AdminHallItem(
                  onLongPress: () {
                    showDeleteItemAlert(
                        context: context,
                        onPressed: () {
                          DataBaseMethouds()
                              .deleteLoc(snapshot.data!.docs[index].id);
                          Navigator.pop(context);
                        });
                  },
                  hallModel: HallModel.fromJson(snapshot.data!.docs[index]
                      .data() as Map<String, dynamic>),
                );
              });
        });
  }
}
