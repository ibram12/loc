import 'package:cloud_firestore/cloud_firestore.dart';

enum ReplyState {
  accepted,
  unaccepted,
  noReplyYet,
}

class UserRequestModel {
  final String hallName;
  final Timestamp endTime;
  final Timestamp startTime;
  final ReplyState replyState;

  UserRequestModel({
    required this.hallName,
    required this.endTime,
    required this.startTime,
    required this.replyState,
  });


}
