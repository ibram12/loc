import 'package:cloud_firestore/cloud_firestore.dart';

enum ReplyState {
  accepted,
  unaccepted,
  noReplyYet,
}
extension ReplyStateExtension on ReplyState {
  String get description {
    switch (this) {
      case ReplyState.accepted:
        return 'Accepted';
      case ReplyState.unaccepted:
        return 'Unaccepted';
      default:
        return 'No reply yet';
    }
  }
}

class UserRequestModel {
//  final String hallName;
  final Timestamp endTime;
  final Timestamp startTime;
  final ReplyState replyState;

  UserRequestModel({
  //  required this.hallName,
    required this.endTime,
    required this.startTime,
    required this.replyState,
  });


}
