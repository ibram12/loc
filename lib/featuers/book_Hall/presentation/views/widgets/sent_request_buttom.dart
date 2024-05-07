import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/add_request/add_request_cubit.dart';
import '../../../../../core/helper/alert_dialog.dart';
import '../../../../../core/helper/snack_bar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';

class SentRequestButtom extends StatefulWidget {
  const SentRequestButtom(
      {super.key,
      required this.hallsIds,
      required this.startTime,
      required this.endTime});
  final List<String> hallsIds;
  final Timestamp startTime;
  final Timestamp endTime;

  @override
  State<SentRequestButtom> createState() => _SentRequestButtomState();
}

class _SentRequestButtomState extends State<SentRequestButtom> {
  late Future<String> requestIdInUserCollection;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentReservationCubit, SentReservationState>(
      builder: (context, state) {
        if (state is SentReservationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAlertDialog(
                context: context, message: 'your request sent successfully');
          });
        } else if (state is SentReservationLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Positioned(
            bottom: 10,
            child: CustomBotton(
              width: MediaQuery.of(context).size.width / 2,
              text: 'sent request',
              onPressed: () async {
                if (widget.hallsIds.isNotEmpty) {
                  requestIdInUserCollection =
                      BlocProvider.of<AddRequestCubit>(context).addRequest(
                          widget.startTime, widget.endTime, widget.hallsIds);
                  await BlocProvider.of<SentReservationCubit>(context)
                      .sentReservation(
                          endTime: widget.endTime,
                          startTime: widget.startTime,
                          data: widget.startTime.toDate(),
                          halls: widget.hallsIds,
                          requestIdInUserCollection: requestIdInUserCollection);
                  await addRequest(
                    context,
                    hallids: widget.hallsIds,
                    endTime: widget.endTime,
                    startTime: widget.startTime,
                  );
                } else {
                  showSnackBar(context, 'please select hall');
                }
              },
              backgroundColor: kPrimaryColor,
            ));
      },
    );
  }

// Future<String> getHallName(List<String> hallIds)async {
  addRequest(
    BuildContext context, {
    required List<String> hallids,
    required Timestamp endTime,
    required Timestamp startTime,
  }) {
    BlocProvider.of<AddRequestCubit>(context)
        .addRequest(startTime, endTime, hallids);
  }
}
