import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/admin_alert_dialog.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/question_dialog.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/request_item_body.dart';
import '../../../../core/helper/alert_dialog.dart';
import '../../../../core/helper/snack_bar.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    super.key,
    required this.requestModel,
    required this.reservationId,
    required this.hallId,
    required this.hallName,
  });
  final RequestModel requestModel;
  final String reservationId;
  final String hallId;
  final String hallName;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditRequestCubit, EditRequestState>(
      listener: (context, state) {
        if (state is EditStartTImeSuccess) {
          BlocProvider.of<EditRequestCubit>(context).selectEndTime(
              context,
              requestModel.endTime.toDate(),
              hallId,
              reservationId,
              requestModel.id,
              requestModel.requestId,
              requestModel.endTime);
        } else if (state is EditEndTimeSuccess) {
          showAlertDialog(
            onOkPressed: () {
              Navigator.of(context).pop();
            },
            context: context,
            message:
                'you have updated this request from ${DateFormat('hh:mm a').format(requestModel.startTime.toDate())} to ${DateFormat('hh:mm a').format(requestModel.endTime.toDate())}',
          );
        }
      },
      child:
          BlocBuilder<AdminChangeDailyStateCubit, AdminChangeDailyStateState>(
        builder: (context, state) {
          if (state is AdminChangeDailyStateFalier) {
            showSnackBar(context, 'sorry there was an error, please try later',
                color: Colors.red);
          }
          return GestureDetector(
              onLongPress: () {
                showQuestionDialog(
                  contextt: context,
                  requestModel: requestModel,
                  reservationId: reservationId,
                  hallId: hallId,
                );
              },
              onTap: () {
                adminAlrtDialog(
                    onEdit: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<EditRequestCubit>(context)
                          .selectStartTime(
                              context,
                              requestModel.startTime.toDate(),
                              hallId,
                              reservationId,
                              requestModel.id,
                              requestModel.requestId,
                              requestModel.startTime);
                    },
                    hallName: hallName,
                    requestModel: requestModel,
                    context: context,
                    onAccept: () {
                      BlocProvider.of<AdminReplyCubit>(context)
                          .adminReplyAccept(
                              hallId: hallId,
                              reservatoinId: reservationId,
                              userId: requestModel.id,
                              requestId: requestModel.requestId);
                      Navigator.of(context).pop();
                    },
                    onReject: () {
                      BlocProvider.of<AdminReplyCubit>(context)
                          .adminReplyReject(
                        hallId: hallId,
                        reservatoinId: reservationId,
                        userId: requestModel.id,
                        requestId: requestModel.requestId,
                      );
                      Navigator.of(context).pop();
                    });
              },
              child: RequestItemBody(
                  requestModel: requestModel,
                  isLoading: state is AdminChangeDailyStateLoading),
                  );
        },
      ),
    );
  }
}
