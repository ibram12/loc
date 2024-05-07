import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;
  final String sendDate;
  final Timestamp startTime;
  final Timestamp endTime;
  final String name;
  final ReplyState replyState;
  RequestModel(
      {required this.sendDate,
      required this.startTime,
      required this.endTime,
      required this.name,
      required this.replyState,
      required this.id});
  factory RequestModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return RequestModel(
      id: documentSnapshot['id'],
      sendDate: documentSnapshot['date'],
      name: documentSnapshot['name'],
      startTime: documentSnapshot['startTime'],
      endTime: documentSnapshot['endTime'],
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
