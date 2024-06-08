import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../generated/l10n.dart';
import 'request_item.dart';

class RequestsViewBody extends StatefulWidget {
  const RequestsViewBody({
    super.key,
    required this.hallId,
    required this.onNumberOfDocsChanged,
    required this.hallName,
  });

  final String hallId;
  final String hallName;
  final void Function(int) onNumberOfDocsChanged;

  @override
  State<RequestsViewBody> createState() => _RequestsViewBodyState();
}

class _RequestsViewBodyState extends State<RequestsViewBody> {
  List<Map<String, dynamic>> requests = [];

  late Query query;
  late Stream<QuerySnapshot> stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = FirebaseFirestore.instance
        .collection('locs')
        .doc(widget.hallId)
        .collection('reservations')
        .orderBy('replyState');
    
    stream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminReplyCubit, AdminReplyState>(
      listener: (context, state) {
        if (state is AdminReplyAccept) {
          showSnackBar(context, S.of(context).request_Accepted_Successfully,
              color: Colors.green);
        } else if (state is AdminReplyReject) {
          showSnackBar(context, S.of(context).request_Rejected_Successfully,
              color: Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AdminReplyLoading,
          child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No Data Found'));
                } else if (snapshot.hasError) {
                  return Center(child: Image.asset('assets/images/error.png'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return RequestItem(
                      hallName: widget.hallName,
                      hallId: widget.hallId,
                      reservationId: snapshot.data!.docs[index].id,
                      requestModel: RequestModel.fromDocumentSnapshot(
                          snapshot.data!.docs[index]),
                    );
                  },
                );
              }),
        );
      },
    );
  }
}
