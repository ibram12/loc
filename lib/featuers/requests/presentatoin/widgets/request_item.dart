import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';

class UserRequestItem extends StatelessWidget {
  const UserRequestItem({super.key, required this.requestModel});
final  UserRequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    requestModel.hallName,
                    overflow: TextOverflow.fade,
                    style: Styles.textStyle18,
                  ),
                  const SizedBox(height: 5),
                   Text(
                    'Date: ${DateFormat('MMMM dd, yyyy').format(requestModel.startTime.toDate())}',
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
              const Spacer(),
              if(requestModel.replyState.description == 'No reply yet')
                CircleAvatar(
                backgroundColor: Colors.amber,
                 radius: 20,
                 child: Image.asset('assets/images/9032185_pending_chatting_load_chat_social media_icon.png',height: 30,),
               ),
               if (requestModel.replyState != ReplyState.noReplyYet)
               CircleAvatar(
                backgroundColor:requestModel.replyState.description == 'accepted' ? Colors.green:Colors.red,
                radius: 20,
                child: Icon(
                  requestModel.replyState.description == 'accepted' ?
                  Icons.check:Icons.close,
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
