import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'get_hall_requests_state.dart';

class GetHallRequestsCubit extends Cubit<GetHallRequestsState> {
  GetHallRequestsCubit() : super(GetHallRequestsInitial());

  Future<void> fetchRequests({required String hallId, required BuildContext context}) async {
    try {
      emit(GetHallRequestsLoading());
      Query query = FirebaseFirestore.instance
          .collection('locs')
          .doc(hallId)
          .collection('reservations')
          .orderBy('replyState');
      query.snapshots().listen((snapshot) {
        List<Map<String, dynamic>> requests = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'request': RequestModel.fromDocumentSnapshot(doc),
          };
        }).toList();
        if (!isClosed) {
          emit(GetHallRequestsSuccess(requests));
        }
      }, onError: (error) {
        if (!isClosed) {
          emit(GetHallRequestsError('${S.of(context).failed_to_fetch_requests}$error'));
        }
      });
    } catch (e) {
      if (!isClosed) {
        emit(GetHallRequestsError(S.of(context).failed_to_fetch_requests));
      }
    }
  }
}
