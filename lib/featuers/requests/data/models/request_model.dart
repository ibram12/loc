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

  factory UserRequestModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    return UserRequestModel(
      hallName: documentSnapshot['hallName'],
      endTime: documentSnapshot['endTime'],
      startTime: documentSnapshot['startTime'],
      replyState: _convertReplyState(documentSnapshot['replyState']),
    );
  }

  static _convertReplyState(String replyState) {
    switch (replyState) {
      case 'Accepted':
        return ReplyState.accepted;
      case 'Unaccepted':
        return ReplyState.unaccepted;
      default:
        return ReplyState.noReplyYet;
    }
  }
}
