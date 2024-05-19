import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';

void showQuestionDialog({
  required BuildContext contextt,
  required RequestModel requestModel,
  required String reservationId,
  required String hallId,
}) {
  showAdaptiveDialog(
    context: contextt,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content:
            const Text('Do you want to confirm the reservation every week?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
            await  BlocProvider.of<AdminChangeDailyStateCubit>(contextt)
                  .adminchageStateToNotDaily(
                      reservatoinId: reservationId,
                      hallId: hallId,
                      userId: requestModel.id,
                      requestId: requestModel.requestId);
          
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  ).then((result) {
    if (result == true) {
      BlocProvider.of<AdminChangeDailyStateCubit>(contextt)
          .adminchageStateToDaily(
              reservatoinId: reservationId,
              hallId: hallId,
              userId: requestModel.id,
              requestId: requestModel.requestId);
    } else {}
  });
}
