import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../data/models/request_model.dart';
import 'request_item.dart';

class RequestsViewBody extends StatefulWidget {
  const RequestsViewBody(
      {super.key,
      required this.hallId,
      required this.onNumberOfDocsChanged,
      required this.hallName});
  final String hallId;
  final String hallName;

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
    return StreamBuilder<QuerySnapshot>(
        stream: reservations.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          widget.onNumberOfDocsChanged(snapshot.data?.docs.length ?? 0);
          return BlocConsumer<AdminReplyCubit, AdminReplyState>(
            listener: (context, state) {
              if(state is AdminTakeAction){
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is AdminReplyLoading,
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return RequestItem(
                        hallName: widget.hallName,
                        hallId: widget.hallId,
                        reservationId: snapshot.data!.docs[index].id,
                        requestModel: RequestModel.fromDocumentSnapshot(
                            snapshot.data!.docs[index]),
                      );
                    }),
              );
            },
          );
        });
  }
}
