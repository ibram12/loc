import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../data/models/request_model.dart';
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
  late Query reservations;

  @override
  void initState() {
    super.initState();
    reservations = FirebaseFirestore.instance
        .collection('locs')
        .doc(widget.hallId)
        .collection('reservations')
        .orderBy('replyState');
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
            if (state is AdminReplyAccept) {
              showSnackBar(context, 'Request Accepted Successfully',
                  color: Colors.green);
            } else if (state is AdminReplyReject) {
              showSnackBar(context, 'Request Rejected Successfully',
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            // Debug statement to check the current weekday
            print('Current weekday: ${DateTime.now().weekday}');

            if (DateTime.now().weekday == DateTime.saturday) {
              DateTime now = DateTime.now();
              DateTime startOfWeek =
                  now.subtract(Duration(days: now.weekday - 1));
              DateTime endOfWeek =
                  now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

              // Debug statements to check the date range
              print('Start of week: $startOfWeek');
              print('End of week: $endOfWeek');

              List<DocumentSnapshot> documentsToDelete = [];

              snapshot.data?.docs.forEach((doc) {
                Timestamp startTime = doc.get('startTime');
                DateTime startTimeDate = startTime.toDate();

                // Debug statements to check each document's date
                print('Document start time: $startTimeDate');

                if (!isWithinCurrentWeek(
                    startTimeDate, startOfWeek, endOfWeek)) {
                  documentsToDelete.add(doc);
                  // Debug statement to check which documents are marked for deletion
                  print('Document marked for deletion: ${doc.id}');
                }
              });

              // Deleting documents
              documentsToDelete.forEach((doc) {
                doc.reference.delete();
                // Debug statement to confirm deletion
                print('Document deleted: ${doc.id}');
              });
            }

            return ModalProgressHUD(
              inAsyncCall: state is AdminReplyLoading,
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return BlocProvider(
                    create: (context) => EditRequestCubit(),
                    child: RequestItem(
                      hallName: widget.hallName,
                      hallId: widget.hallId,
                      reservationId: snapshot.data!.docs[index].id,
                      requestModel: RequestModel.fromDocumentSnapshot(
                          snapshot.data!.docs[index]),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  bool isWithinCurrentWeek(
      DateTime date, DateTime startOfWeek, DateTime endOfWeek) {
    return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }
}
