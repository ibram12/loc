import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ReplyState { accepted, unaccepted, noReplyYet, modified }

extension ReplyStateExtension on ReplyState {
  String get description {
    switch (this) {
      case ReplyState.accepted:
        return 'Accepted';
      case ReplyState.unaccepted:
        return 'Unaccepted';
      case ReplyState.noReplyYet:
        return 'No reply yet';
      case ReplyState.modified:
        return 'Modified';
      default:
        return 'No reply yet';
    }
  }
}

class UserRequestModel {
  final String id;
  final String hallName;
  final String hallId;
  final String userId;
  final Timestamp endTime;
  final Timestamp startTime;
  final ReplyState replyState;
  final String requestId;
  final bool daily;
  final String service;
  final bool adminModification;
  final String? modifier;
  final String? modifiedDoc;
  final String? modiferAdminToken;

  UserRequestModel(
    this.modifier, {
      required this.modiferAdminToken,
    required this.modifiedDoc,
    required this.adminModification,
    required this.service,
    required this.id,
    required this.hallId,
    required this.userId,
    required this.daily,
    required this.hallName,
    required this.endTime,
    required this.startTime,
    required this.replyState,
    required this.requestId,
  });

  factory UserRequestModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return UserRequestModel(
      modiferAdminToken: data['modiferAdminToken'],
      modifiedDoc: data['modifiedDoc'],
      data['modifer'] ?? '',
      adminModification: data['adminModified'],
      service: data['service'],
      id: documentSnapshot.id,
      hallId: data['hallId'],
      userId:  userId,
      hallName: data['hallName'],
      endTime: data['endTime'],
      startTime: data['startTime'],
      replyState: _convertReplyState(data['replyState']),
      requestId: data['requestId'],
      daily: data['daily'],
    );
  }

  static ReplyState _convertReplyState(String replyState) {
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
