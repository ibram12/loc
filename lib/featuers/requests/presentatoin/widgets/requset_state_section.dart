import 'package:flutter/material.dart';

import '../../data/models/user_request_model.dart';

class RequestStateSection extends StatelessWidget {
  const RequestStateSection({super.key, required this.requestModel});
  final UserRequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (requestModel.replyState == ReplyState.noReplyYet)
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
            backgroundColor: requestModel.replyState == ReplyState.accepted
                ? Colors.green
                : Colors.red,
            radius: 20,
            child: Icon(
              requestModel.replyState == ReplyState.accepted
                  ? Icons.check
                  : Icons.close,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
