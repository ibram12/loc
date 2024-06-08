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

  Future<void> fetchRequests(
      {required String hallId, required BuildContext context}) async {
    try {
      emit(GetHallRequestsLoading());
      Query query = FirebaseFirestore.instance
          .collection('locs')
          .doc(hallId)
          .collection('reservations')
          .orderBy('replyState');
              query.snapshots().listen((snapshot) {
      //  _checkAndDeleteRequests(query);
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
          emit(GetHallRequestsError(
              '${S.of(context).failed_to_fetch_requests}$error'));
        }
      });
          
    
    } catch (e) {
      if (!isClosed) {
        emit(GetHallRequestsError(S.of(context).failed_to_fetch_requests));
      }
    }
  }

  Future<void> _checkAndDeleteRequests(Query query) async {
    try {
      String? lastDeletionDateStr;
      DateTime now = DateTime.now();
      FirebaseFirestore.instance
          .collection('admin')
          .doc('deletionDate')
          .get()
          .then((value) {
        lastDeletionDateStr = value.get('lastDeletionDate');
      });

      DateTime lastDeletionDate = lastDeletionDateStr != null
          ? DateTime.parse(lastDeletionDateStr!)
          : DateTime(2023);

      if (now.weekday == DateTime.saturday &&
          !_isSameDay(now, lastDeletionDate)) {
        QuerySnapshot snapshot = await query.get();
        List<DocumentSnapshot> documentsToDelete = [];
        for (var doc in snapshot.docs) {
          bool? daily;
          try {
            daily = doc.get('daily');
          } catch (e) {
            continue; // Skip this document if it has missing fields
          }

          if (daily == false) {
            documentsToDelete.add(doc);
            for (var doc in documentsToDelete) {
              await doc.reference.delete();
            }

            await FirebaseFirestore.instance
                .collection('admin')
                .doc('deletionDate')
                .update({'lastDeletionDate': now.toString()});
          }
        }
      }
    } catch (e) {
      print('Error in _checkAndDeleteRequests: $e');
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
