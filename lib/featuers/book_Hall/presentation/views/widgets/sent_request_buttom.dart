import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/add_request/add_request_cubit.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';

import '../../../../../core/helper/alert_dialog.dart';
import '../../../../../core/helper/snack_bar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';

class SentRequestButtom extends StatelessWidget {
  const SentRequestButtom(
      {super.key,
      required this.hallsIds,
      required this.startTime,
      required this.endTime});
  final List<String> hallsIds;
  final Timestamp startTime;
  final Timestamp endTime;
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
              onPressed: ()async {
                if (hallsIds.isNotEmpty) {
                await  BlocProvider.of<SentReservationCubit>(context)
                      .sentReservation(
                          endTime: endTime,
                          startTime: startTime,
                          data: startTime.toDate(),
                          halls: hallsIds);
                  addRequest(
                    context,
                    hallids: hallsIds,
                    endTime: endTime,
                    startTime: startTime,
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
//     return await FirebaseFirestore.instance
//         .collection('locs')
//         .doc(hallIds)
//         .get()
//         .then((value) {
//       return value.data()!['name'];
//     });
//   }

  addRequest(
    BuildContext context, {
    required List<String> hallids,
    required Timestamp endTime,
    required Timestamp startTime,
  }) {
    BlocProvider.of<AddRequestCubit>(context).addRequest(UserRequestModel(
      //  hallName: hallName,
        endTime: endTime,
        startTime: startTime,
        replyState: ReplyState.noReplyYet,),hallids);
  }
}
