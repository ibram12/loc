import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dalog.dart';
import 'package:loc/core/helper/daily_questoin_dialog.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/add_request/add_request_cubit.dart';
import '../../../../../core/helper/snack_bar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentaiton/views/homePage.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';

class SentRequestButtom extends StatefulWidget {
  const SentRequestButtom(
      {super.key,
      required this.hallNames,
      required this.hallsIds,
      required this.startTime,
      required this.endTime, required this.selectedService});
  final List<String> hallsIds;
  final Timestamp startTime;
  final Timestamp endTime;
  final String selectedService;
  final List<String> hallNames;

  @override
  State<SentRequestButtom> createState() => _SentRequestButtomState();
}

class _SentRequestButtomState extends State<SentRequestButtom> {
  late Future<List<String>> requestIdInUserCollection;

  Future<void> _sentReservation(bool daily) async {
    Navigator.pop(context);
    requestIdInUserCollection = BlocProvider.of<AddRequestToUserCubit>(context)
        .addRequest(widget.startTime, widget.endTime, widget.hallsIds, daily,widget.selectedService);

    await BlocProvider.of<SentReservationToAdminCubit>(context).sentReservation(
        hallNames: widget.hallNames,
        isDaily: daily,
        endTime: widget.endTime,
        startTime: widget.startTime,
        data: widget.startTime.toDate(),
        halls: widget.hallsIds,
        requestIdsInUserCollection: requestIdInUserCollection,
        selectedService: widget.selectedService
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentReservationToAdminCubit, SentReservationState>(
      builder: (context, state) {
        if (state is SentReservationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAlertDialog(
                onOkPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                      (route) => false);
                },
                context: context,
                message: S.of(context).your_request_sent_successfully);
          });
        }
        return Positioned(
            bottom: 10,
            child: CustomBotton(
              width: MediaQuery.of(context).size.width / 2,
              text: S.of(context).sent_request,
              onPressed: () async {
                if (widget.hallsIds.isNotEmpty) {
                  showDailyQuestion(
                    context: context,
                    onChoiseNotDaily: () async => await _sentReservation(false),
                    onChoiseDaily: () async => await _sentReservation(true),
                  );
                } else {
                  showSnackBar(context, S.of(context).please_select_hall);
                }
              },
              backgroundColor: kPrimaryColor,
            ));
      },
    );
  }
}
