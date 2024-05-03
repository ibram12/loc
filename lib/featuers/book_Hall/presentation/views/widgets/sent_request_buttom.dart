import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/alert_dialog.dart';
import '../../../../../core/helper/snack_bar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';

class SentRequestButtom extends StatelessWidget {
  const SentRequestButtom({super.key, required this.hallsIds, required this.startTime, required this.endTime});
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
              onPressed: () {
                if (hallsIds.isNotEmpty) {
                  BlocProvider.of<SentReservationCubit>(context)
                      .sentReservation(
                          endTime: endTime,
                          startTime: startTime,
                          data: startTime.toDate(),
                          halls: hallsIds);
                } else {
                  showSnackBar(context, 'please select hall');
                }
              },
              backgroundColor: kPrimaryColor,
            ));
      },
    );
  }
}
