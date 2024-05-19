import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/pressntation/widgets/admin_hall_item.dart';

import '../../../../core/helper/delete_alert_dialog.dart';
import '../../../../core/server/firebase_methoudes.dart';
import '../../data/models/admin_hall_model.dart';
import '../manager/featch_end_times_cubit/featch_the_end_times_cubit.dart';

class AllHallsListView extends StatefulWidget {
  const AllHallsListView({super.key});

  @override
  State<AllHallsListView> createState() => _AllHallsListViewState();
}

class _AllHallsListViewState extends State<AllHallsListView> {
  final Stream<QuerySnapshot> _hallsStream =
      FirebaseFirestore.instance.collection('locs').snapshots();
  late Map<String, int> reservationsCounts = {};
  late Map<String, Duration?> remainingTimes = {};

  @override
  void initState() {
    super.initState();
    _fetchReservationsCounts();
    BlocProvider.of<FeatchTheEndTimesCubit>(context).featchTheRemainingTime();
  }

  Future<void> _fetchReservationsCounts() async {
    final halls = await FirebaseFirestore.instance.collection('locs').get();
    for (final hall in halls.docs) {
      final reservations = await FirebaseFirestore.instance
          .collection('locs')
          .doc(hall.id)
          .collection('reservations')
          .get();
      reservationsCounts[hall.id] = reservations.docs.length;
      remainingTimes[hall.id] = null; // Initialize remaining times with null
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeatchTheEndTimesCubit, FeatchTheEndTimesState>(
      listener: (context, state) {
        if (state is ThereWasReservationInTheCruntTime) {
          setState(() {
            remainingTimes[state.hallId] = state.remainingTime;
          });
        } else if (state is NoReservationInTheCruntTime) {
          setState(() {
            remainingTimes[state.hallId] = null;
          });
        }
      },
      child: StreamBuilder<QuerySnapshot<Object?>>(
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
              final hallId = snapshot.data!.docs[index].id;
              final reservationsCount = reservationsCounts[hallId] ?? 0;
              final remainingTime = remainingTimes[hallId];

              return AdminHallItem(
                hallid: hallId,
                onLongPress: () {
                  showDeleteItemAlert(
                    context: context,
                    onPressed: () {
                      DataBaseMethouds().deleteLoc(hallId);
                      Navigator.pop(context);
                    },
                  );
                },
                hallModel: AdminHallModel.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>,
                  reservationsCount,
                ),
                remainingTime: remainingTime,
              );
            },
          );
        },
      ),
    );
  }
}
