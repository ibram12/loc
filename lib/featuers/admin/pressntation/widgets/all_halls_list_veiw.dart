import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/pressntation/widgets/admin_hall_item.dart';

import '../../../../core/helper/delete_alert_dialog.dart';
import '../../../../core/server/firebase_methoudes.dart';
import '../../../../core/views/error_view.dart';
import '../../../../core/widgets/hall_list_view_loading_indecator.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/admin_hall_model.dart';
import '../manager/cubit/featch_reservaion_counts_cubit.dart';
import '../manager/featch_end_times_cubit/featch_the_end_times_cubit.dart';

class AllHallsListView extends StatefulWidget {
  const AllHallsListView({super.key});

  @override
  State<AllHallsListView> createState() => _AllHallsListViewState();
}

class _AllHallsListViewState extends State<AllHallsListView> {
  final Stream<QuerySnapshot> _hallsStream =
      FirebaseFirestore.instance.collection('locs').snapshots();
   Map<String, int> reservationsCounts = {};
  late Map<String, Duration?> remainingTimes = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FeatchReservaionCountsCubit>(context)
        .fetchReservationsCounts()
        .then((_) {
      BlocProvider.of<FeatchTheEndTimesCubit>(context)
          .featchTheRemainingTime()
          .whenComplete(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatchReservaionCountsCubit,
        FeatchReservaionCountsState>(
         builder: (context, state) {
      if (state is FeatchReservaionCountsLoading) {
        return const HallListViewLoadingIndecator(
          scrollDirection: Axis.vertical,
        );
      } else {
        if (state is FeatchReservaionCountsLoaded) {
          reservationsCounts = state.reservationsCounts;
    
      }
      return  BlocConsumer<FeatchTheEndTimesCubit, FeatchTheEndTimesState>(
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
          builder: (context, state) {
            if (state is FeathTheEndTimesLoading) {
              return const HallListViewLoadingIndecator(
                scrollDirection: Axis.vertical,
              );
            } else if (state is ThereWasReservationInTheCruntTime ||
                state is NoReservationInTheCruntTime) {
              return StreamBuilder<QuerySnapshot<Object?>>(
                stream: _hallsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                        S.of(context).something_went_wrong_please_try_later);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const HallListViewLoadingIndecator(
                      scrollDirection: Axis.vertical,
                    );
                  }
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final hallId = snapshot.data!.docs[index].id;
                      final reservationsCount = reservationsCounts[hallId] ?? 0;
                      final remainingTime = remainingTimes[hallId];

                      return AdminHallItem(
                        hallid: hallId,
                        onLongPress: () {
                          showItemAlertDialog(
                            title: S.of(context).remove_hall,
                            content: S.of(context).hall,
                            context: context,
                            onPressed: () {
                              DataBaseMethouds().deleteLoc(hallId);
                              Navigator.pop(context);
                            },
                          );
                        },
                        hallModel: AdminHallModel.fromJson(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                          reservationsCount,
                        ),
                        remainingTime: remainingTime,
                      );
                    },
                  );
                },
              );
            } else if (state is FeatchTheEndTimesFailer) {
              return ErrorView(
                visable: true,
                onRetry: () {
                  BlocProvider.of<FeatchTheEndTimesCubit>(context)
                      .featchTheRemainingTime();
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      }
    });
  }
}
