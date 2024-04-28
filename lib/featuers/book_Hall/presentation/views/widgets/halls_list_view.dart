import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';
import 'hall_item.dart';

class HallsListView extends StatefulWidget {
  const HallsListView({
    Key? key,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final Timestamp startTime;
  final Timestamp endTime;

  @override
  State<HallsListView> createState() => _HallsListViewState();
}

class _HallsListViewState extends State<HallsListView> {
  late Stream<List<QueryDocumentSnapshot>> _hallsStream;
  late Query _hallsQuery;

  @override
  void initState() {
    super.initState();
    _hallsQuery = FirebaseFirestore.instance.collection('locs').doc().collection('reservations')
    .where('startTime', isGreaterThan: widget.startTime.toDate()).where('endTime', isLessThan: widget.endTime.toDate()).orderBy('startTime', descending: false);
    _hallsStream = _hallsQuery.snapshots().map((snapshot) => snapshot.docs
        .cast<QueryDocumentSnapshot>()
        .toList());
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot>>(
      stream: _hallsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          itemCount: snapshot.data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return HallItem(
              hallId: snapshot.data![index].id,
              hallModel: HallModel.fromJson(
                  snapshot.data![index].data() as Map<String, dynamic>),
            );
          },
        );
      },
    );
  }

  

}
