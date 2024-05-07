import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/admin_alert_dialog.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/cubit/admin_reply_cubit.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    super.key,
    required this.requestModel, required this.hallid,
  });
  final RequestModel requestModel;
  final String hallid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        adminAlrtDialog(context: context, onAccept: () {
        //  BlocProvider.of<AdminReplyCubit>(context).adminReplyAccept(hallid: hallid, userId: requestModel.id, requestId: );
        }, onReject: () {});
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Start Time: ${DateFormat('MMMM dd, yyyy - hh:mm a').format(requestModel.startTime.toDate())}',
                    style: Styles.textStyle16,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'End Time: ${DateFormat('MMMM dd, yyyy - hh:mm a').format(requestModel.endTime.toDate())}',
                    style: Styles.textStyle16,
                  ),
                ],
              ),
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
                  backgroundColor:
                      requestModel.replyState.description == 'Accepted'
                          ? Colors.green
                          : Colors.red,
                  radius: 20,
                  child: Icon(
                    requestModel.replyState.description == 'Accepted'
                        ? Icons.check
                        : Icons.close,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
