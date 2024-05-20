import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';

import '../../../../core/text_styles/Styles.dart';

class RequestItemBody extends StatelessWidget {
  const RequestItemBody({super.key, required this.requestModel, required this.isLoading});
  final RequestModel requestModel;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Banner(
      message: requestModel.daily == false ? 'Not Daily' : 'Daily',
      color: requestModel.daily == false ? Colors.red : Colors.green,
      location: BannerLocation.topEnd,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Row(
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
                          'Date: ${DateFormat('dd-MM-yyyy').format(requestModel.startTime.toDate())}',
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
    );
  }
}
