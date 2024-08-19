import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:meta/meta.dart';

import '../../../../../core/notifications/get_user_token.dart';
import '../../../../../generated/l10n.dart';
import '../../../../admin/pressntation/view/bottomNav_bar.dart';
import '../../../data/models/user_request_model.dart';

part 'user_accept_admin_offer_state.dart';

class UserAcceptAdminOfferCubit extends Cubit<UserAcceptAdminOfferState> {
  UserAcceptAdminOfferCubit() : super(UserAcceptAdminOfferInitial());

  Future<void> userAcceptUserOffer(
      {required UserRequestModel userRequestModel,
      required BuildContext context}) async {
    emit(UserAcceptAdminOfferLoading());
    List<String> pathsToUpdate = [
      'locs/${userRequestModel.hallId}/reservations/${userRequestModel.modifiedDoc}',
      'users/${userRequestModel.userId}/requests/${userRequestModel.requestId}',
    ];
    for (var path in pathsToUpdate) {
      await FirebaseFirestore.instance.doc(path).update({
        'adminModified': false,
        'replyState': ReplyState.accepted.description,
      }).onError((e, s) {
        emit(UserAcceptAdminOfferError(
            err:
                S.of(context).there_was_a_problem_during_the_approval_process));
      });
    }
    if (userRequestModel.modiferAdminToken != null) {
      final name = await SherdPrefHelper().getUserName();
      PushNotificationService.sendNotificationToSelectedUser(
        deviceToken: userRequestModel.modiferAdminToken!,
        screen: BottomNavBar.id,
        title: 'عرضك مقبول',
        body: 'تم قبول طلب التعديل الذي ارسلته الى $name',
      );
    }

    emit(UserAcceptAdminOfferSuccess());
  }
}
