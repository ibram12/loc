import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../requests/data/models/request_model.dart';

part 'admin_reply_state.dart';

class AdminReplyCubit extends Cubit<AdminReplyState> {
  AdminReplyCubit() : super(AdminReplyInitial());
  Future<void> adminReplyAccept(
      {required String reservatoinId,
      required String hallId,
      required String userId,
      required String requestId}) async {
    emit(AdminTakeAction());

    emit(AdminReplyLoading());

    await FirebaseFirestore.instance
        .collection('locs')
        .doc(hallId)
        .collection('reservations')
        .doc(reservatoinId)
        .update({'replyState': ReplyState.accepted.description});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('requests')
        .doc(requestId)
        .update({'replyState': ReplyState.accepted.description});
    emit(AdminReplyAccept());
  }

  Future<void> adminReplyReject(
      {required String reservatoinId,
      required String hallId,
      required String userId,
      required String requestId}) async {
    emit(AdminTakeAction());
    emit(AdminReplyLoading());
    await FirebaseFirestore.instance
        .collection('locs')
        .doc(hallId)
        .collection('reservations')
        .doc(reservatoinId)
        .update({'replyState': ReplyState.unaccepted.description});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('requests')
        .doc(requestId)
        .update({'replyState': ReplyState.unaccepted.description});
    emit(AdminReplyReject());
  }
}
