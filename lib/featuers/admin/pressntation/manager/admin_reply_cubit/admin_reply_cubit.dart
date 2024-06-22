import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/notifications/get_user_token.dart';
import 'package:loc/core/server/shered_pref_helper.dart';

import '../../../../../generated/l10n.dart';
import '../../../../requests/data/models/user_request_model.dart';
import '../../../../requests/presentatoin/views/requests_view.dart';
import '../../../data/models/request_model.dart';

part 'admin_reply_state.dart';

class AdminReplyCubit extends Cubit<AdminReplyState> {
  AdminReplyCubit() : super(AdminReplyInitial());
  Future<void> adminReplyAccept(
      {required String reservatoinId,
      required RequestModel requestModel,
      required String hallName,required BuildContext context}) async {
        String? adminName = await SherdPrefHelper().getUserName();
    emit(AdminReplyLoading());

    WriteBatch batch = FirebaseFirestore.instance.batch();

    List<String> pathsToUpdate = [
      'locs/${requestModel.hallId}/reservations/$reservatoinId',
      'users/${requestModel.id}/requests/${requestModel.requestId}',
    ];

    for (var path in pathsToUpdate) {
      batch.update(FirebaseFirestore.instance.doc(path),
          {'replyState': ReplyState.accepted.description});
    }

    batch.commit();
    PushNotificationService.sendNotificationToSelectedUser(
      screen: UserRequests.id,
      deviceToken: requestModel.userToken,
      title: S.of(context).request_accepted,
      body: "${requestModel.name} ${S.of(context).mokadma} $hallName ${S.of(context).hall_has_been_accepted} $adminName",
    );
    emit(AdminReplyAccept());
  }

  Future<void> adminReplyReject(
      {required String reservatoinId,
      required RequestModel requestModel,
      required BuildContext context,
      required String hallName}) async {
    String? adminName = await SherdPrefHelper().getUserName();

    emit(AdminReplyLoading());
    WriteBatch batch = FirebaseFirestore.instance.batch();

    List<String> pathsToUpdate = [
      'locs/${requestModel.hallId}/reservations/$reservatoinId',
      'users/${requestModel.id}/requests/${requestModel.requestId}',
    ];
    for (var path in pathsToUpdate) {
      batch.update(FirebaseFirestore.instance.doc(path),
          {'replyState': ReplyState.unaccepted.description});
    }
    batch.commit();
    PushNotificationService.sendNotificationToSelectedUser(
      screen: UserRequests.id,
      deviceToken: requestModel.userToken,
      title: S.of(context).request_rejected,
      body: "${requestModel.name} ${S.of(context).mokadma} $hallName ${S.of(context).hall_has_been_rejected} $adminName",
    );

    emit(AdminReplyReject());
  }
}
