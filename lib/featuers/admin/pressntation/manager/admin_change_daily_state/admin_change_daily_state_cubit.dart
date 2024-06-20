import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../requests/data/models/user_request_model.dart';

part 'admin_change_daily_state_state.dart';

class AdminChangeDailyStateCubit extends Cubit<AdminChangeDailyStateState> {
  AdminChangeDailyStateCubit() : super(AdminChangeDailyStateInitial());
  Future<void> adminchageStateToDaily(
      {required String reservatoinId,
      required String hallId,
      required String userId,
      required String requestId}) async {
    emit(AdminChangeDailyStateLoading());

    WriteBatch batch = FirebaseFirestore.instance.batch();

    List<String> pathsToUpdate = [
      'locs/$hallId/reservations/$reservatoinId',
      'users/$userId/requests/$requestId',
    ];

    for (var path in pathsToUpdate) {
      batch.update(FirebaseFirestore.instance.doc(path), {'daily': true,'replyState': ReplyState.accepted.description});
    }
    try {
      await batch.commit();

      emit(AdminChangeDailyStateToDaily());
    } catch (e) {
      emit(AdminChangeDailyStateFalier());
    }
  }

  Future<void> adminchageStateToNotDaily(
      {required String reservatoinId,
      required String hallId,
      required String userId,
      required String requestId}) async {
    emit(AdminChangeDailyStateLoading());

    WriteBatch batch = FirebaseFirestore.instance.batch();

    List<String> pathsToUpdate = [
      'locs/$hallId/reservations/$reservatoinId',
      'users/$userId/requests/$requestId',
    ];

    for (var path in pathsToUpdate) {
      batch.update(FirebaseFirestore.instance.doc(path), {'daily': false});
    }
    try {
      batch.commit();
      emit(AdminChangeDailyStateToNotDaily());
    } catch (e) {
      emit(AdminChangeDailyStateFalier());
    }
  }
}
