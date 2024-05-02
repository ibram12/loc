import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';
import '../../../../../core/helper/alert_dialog.dart';
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
  List<String> hallsIds = [];
  @override
  void initState() {
    super.initState();
    _hallsStream = _getHallsStream();
  }

  Stream<List<QueryDocumentSnapshot>> _getHallsStream() async* {
    final locsRef = FirebaseFirestore.instance.collection('locs');
    // Query for reservations that overlap with the selected time range
    final QuerySnapshot overlappingReservationsQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('reservations')
            .where('endTime', isGreaterThan: widget.startTime)
            .get();
    // Extract the hall IDs with overlapping reservations
    final List<String> hallsWithOverlappingReservations =
        overlappingReservationsQuerySnapshot.docs
            .where(
                (doc) => doc.get('startTime').toDate().isBefore(widget.endTime))
            .map((doc) => doc.get('hallId') as String)
            .toList();
    // Query for all halls
    final QuerySnapshot allHallsQuerySnapshot = await locsRef.get();
    // Extract the hall IDs
    final List<String> allHallIds =
        allHallsQuerySnapshot.docs.map((doc) => doc.id).toList();
    // Filter out halls with overlapping reservations
    final List<String> availableHallIds = allHallIds
        .where((hallId) => !hallsWithOverlappingReservations.contains(hallId))
        .toList();
    // Retrieve the documents for available halls
    final List<QueryDocumentSnapshot> availableHallsSnapshot = await locsRef
        .where(FieldPath.documentId, whereIn: availableHallIds)
        .get()
        .then((value) => value.docs);

    yield availableHallsSnapshot;
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
        return Stack(alignment: Alignment.bottomCenter, children: [
          GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return HallItem(
                selectedHalls: hallsIds,
                onSelectionChanged: (isSelected, hallId) {
                  setState(() {
                    if (isSelected) {
                      hallsIds.add(hallId);
                    } else {
                      hallsIds.removeAt(hallsIds.indexOf(hallId));
                    }
                  });
                },
                hallId: snapshot.data![index].id,
                hallModel: HallModel.fromJson(
                    snapshot.data![index].data() as Map<String, dynamic>),
              );
            },
          ),
          BlocBuilder<SentReservationCubit, SentReservationState>(
            builder: (context, state) {
              if (state is SentReservationSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showAlertDialog(
                      context: context,
                      message: 'your request sent successfully');
                });
              } else if (state is SentReservationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Positioned(
                  bottom: 10,
                  child: CustomBotton(
                    width: MediaQuery.of(context).size.width / 2,
                    text: 'sent request',
                    onPressed: () {
                      if (hallsIds.isNotEmpty) {
                        BlocProvider.of<SentReservationCubit>(context)
                            .sentReservation(
                                endTime: widget.endTime,
                                startTime: widget.startTime,
                                data: widget.startTime.toDate(),
                                halls: hallsIds);
                      } else {
                  showSnackBar(context, 'please select hall');
                      }
                    },
                    backgroundColor: kPrimaryColor,
                  ));
            },
          )
        ]);
      },
    );
  }
}
