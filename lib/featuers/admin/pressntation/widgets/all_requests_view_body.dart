import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/pressntation/widgets/custom_divider.dart';
import 'package:loc/featuers/admin/pressntation/widgets/request_item.dart';

import '../../data/models/request_model.dart';
import '../manager/get_all_requests_cubit/get_all_requests_cubit.dart';

class AllRequestsViewBody extends StatefulWidget {
  const AllRequestsViewBody({super.key});

  @override
  State<AllRequestsViewBody> createState() => _AllRequestsViewBodyState();
}

class _AllRequestsViewBodyState extends State<AllRequestsViewBody> {
  Map<String, String> hallNameToId = {};

  @override
  void initState() {
    super.initState();
    context.read<GetAllRequestsCubit>().getHallsRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllRequestsCubit, GetAllRequestsState>(
      listener: (context, state) {
        if (state is GetAllHallsRequestsDone) {
          setState(() {
            hallNameToId = {
              for (var i = 0; i < state.allHallsNames.length; i++)
                state.allHallRequests[i]: state.allHallsNames[i]
            };
          });
        }
      },
      builder: (context, state) {
        if (state is GetAllHallReservaionsFailer) {
          return Center(
            child: Text(
              state.massege,
              style: Styles.textStyle18,
            ),
          );
        }
        return CustomScrollView(
          slivers: hallNameToId.entries.map((entry) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomDiveder(hallName: entry.key),
                      StreamBuilder<QuerySnapshot<Object?>>(
                        stream: FirebaseFirestore.instance
                            .collection("locs")
                            .doc(entry.value)
                            .collection("reservations")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return Column(
                            children: snapshot.data!.docs.map((doc) {
                              final requestModel = RequestModel.fromDocumentSnapshot(doc);
                              return RequestItem(
                                requestModel: requestModel,
                                reservationId: doc.id,
                                hallId: entry.value,
                                hallName: entry.key,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
