import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              state.allHallRequests[i]  : state.allHallsNames[i]
            };
          });
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: hallNameToId.entries.map((entry) {
            return SliverToBoxAdapter(
              child: Column(
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
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final requestModel = RequestModel.fromDocumentSnapshot(snapshot.data!.docs[index]);
                          return RequestItem(
                            requestModel: requestModel,
                            reservationId: snapshot.data!.docs[index].id,
                            hallId: entry.value,
                            hallName: entry.key,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
