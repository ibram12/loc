import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';
import 'package:meta/meta.dart';

import '../../../../../core/notifications/get_user_token.dart';
import '../../../../../core/server/shered_pref_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../admin/pressntation/view/bottomNav_bar.dart';

part 'user_reject_admin_offer_state.dart';

class UserRejectAdminOfferCubit extends Cubit<UserRejectAdminOfferState> {
  UserRejectAdminOfferCubit() : super(UserRejectAdminOfferInitial());

  Future<void> userRejectAdminOffer({required UserRequestModel userRequestModel,required BuildContext context})async{
    emit(UserRejectAdminOfferLoading());
    List<String> pathsToUpdate = [
      'locs/${userRequestModel.hallId}/reservations/${userRequestModel.modifiedDoc}',
      'users/${userRequestModel.userId}/requests/${userRequestModel.requestId}',
    ];
    for (var path in pathsToUpdate) {
      await FirebaseFirestore.instance.doc(path).delete().onError((e, s) {
        emit(UserRejectAdminOfferError(
            err:
                S.of(context).there_was_a_problem_during_the_approval_process));
      });
    }
    if (userRequestModel.modiferAdminToken != null) {
      final name = await SherdPrefHelper().getUserName();
      PushNotificationService.sendNotificationToSelectedUser(
        deviceToken: userRequestModel.modiferAdminToken!,
        screen: BottomNavBar.id,
        title: 'عرضك مرفوض',
        body: 'تم رفض طلب التعديل الذي ارسلته الى $name',
      );
    }

    emit(UserRejectAdminOfferSuccess());
  }
}
