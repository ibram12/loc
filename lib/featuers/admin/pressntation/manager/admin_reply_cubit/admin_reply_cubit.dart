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


    emit(AdminReplyLoading());

    WriteBatch batch = FirebaseFirestore.instance.batch();

    List<String> pathsToUpdate = [
      'locs/$hallId/reservations/$reservatoinId',
      'users/$userId/requests/$requestId',
    ];

    for (var path in pathsToUpdate) {
      batch.update(FirebaseFirestore.instance.doc(path),
          {'replyState': ReplyState.accepted.description});
    }

    batch.commit();
    emit(AdminReplyAccept());
  }

  Future<void> adminReplyReject(
      {required String reservatoinId,
      required String hallId,
      required String userId,
      required String requestId}) async {

    emit(AdminReplyLoading());
    WriteBatch batch = FirebaseFirestore.instance.batch();

    List<String> pathsToUpdate = [
      'locs/$hallId/reservations/$reservatoinId',
      'users/$userId/requests/$requestId',
    ];
    for (var path in pathsToUpdate) {
      batch.update(FirebaseFirestore.instance.doc(path),
          {'replyState': ReplyState.unaccepted.description});
    }
    batch.commit();
    emit(AdminReplyReject());
  }
}
