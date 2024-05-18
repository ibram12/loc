import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/admin_alert_dialog.dart';
import 'package:loc/core/helper/question_dialog.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';

import '../../../../core/helper/alert_dialog.dart';

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
      child: GestureDetector(
        onLongPress: () {
          showQuestionDialog(
            context: context,
            requestModel: requestModel,
            reservationId: reservationId,
            hallId: hallId,
          );
        },
        onTap: () {
          adminAlrtDialog(
              onEdit: () {
                Navigator.of(context).pop();
                BlocProvider.of<EditRequestCubit>(context).selectStartTime(
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
                BlocProvider.of<AdminReplyCubit>(context).adminReplyAccept(
                    hallId: hallId,
                    reservatoinId: reservationId,
                    userId: requestModel.id,
                    requestId: requestModel.requestId);
                Navigator.of(context).pop();
              },
              onReject: () {
                BlocProvider.of<AdminReplyCubit>(context).adminReplyReject(
                  hallId: hallId,
                  reservatoinId: reservationId,
                  userId: requestModel.id,
                  requestId: requestModel.requestId,
                );
                Navigator.of(context).pop();
              });
        },
        child: Banner(
          message: requestModel.daily == false ? 'Not Daily' : 'Daily',
          color: requestModel.daily == false ? Colors.red : Colors.green,
          location: BannerLocation.topEnd,
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requestModel.name,
                        overflow: TextOverflow.fade,
                        style: Styles.textStyle18,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${requestModel.sendDate}',
                        style: Styles.textStyle16,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Start Time: ${DateFormat('hh:mm a').format(requestModel.startTime.toDate())}',
                        style: Styles.textStyle16,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'End Time: ${DateFormat('hh:mm a').format(requestModel.endTime.toDate())}',
                        style: Styles.textStyle16,
                      ),
                    ],
                  ),
                  Spacer(),
                  if (requestModel.replyState.description == 'No reply yet')
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 20,
                      child: Image.asset(
                        'assets/images/9032185_pending_chatting_load_chat_social media_icon.png',
                        height: 30,
                      ),
                    ),
                  if (requestModel.replyState != ReplyState.noReplyYet)
                    CircleAvatar(
                      backgroundColor: requestModel.replyState.description ==
                              ReplyState.accepted.description
                          ? Colors.green
                          : Colors.red,
                      radius: 20,
                      child: Icon(
                        requestModel.replyState.description ==
                                ReplyState.accepted.description
                            ? Icons.check
                            : Icons.close,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
