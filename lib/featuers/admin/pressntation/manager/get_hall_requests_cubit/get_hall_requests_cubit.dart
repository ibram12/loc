import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:meta/meta.dart';

import '../../../../../core/server/shered_pref_helper.dart';

part 'get_hall_requests_state.dart';

class GetHallRequestsCubit extends Cubit<GetHallRequestsState> {
  GetHallRequestsCubit() : super(GetHallRequestsInitial());
  Future<void> featchRequests({required String hallId}) async {
    try {
      emit(GetHallRequestsLoading());
      Query query = FirebaseFirestore.instance
          .collection('locs')
          .doc(hallId)
          .collection('reservations')
          .orderBy('replyState');
     query.snapshots().listen((snapshot) {//TODO: HANDLE THIS IN FUTURE
        _checkAndDeleteRequests(query);
        List<Map<String, dynamic>> requests = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'request': RequestModel.fromDocumentSnapshot(doc),
          };
        }).toList();
        emit(GetHallRequestsSuccess(requests));
      });
    } catch (e) {
      emit(GetHallRequestsError('Failed to fetch requests'));
    }
  }

  Future<void> _checkAndDeleteRequests(Query query) async {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

    String? lastDeletionDateStr = await SherdPrefHelper().getLastDeletionDate();
    DateTime lastDeletionDate = lastDeletionDateStr != null
        ? DateTime.parse(lastDeletionDateStr)
        : DateTime(2023);

    if (now.weekday == DateTime.saturday &&
        !_isSameDay(now, lastDeletionDate)) {
      QuerySnapshot snapshot = await query.get();
      List<DocumentSnapshot> documentsToDelete = [];
      for (var doc in snapshot.docs) {
        Timestamp startTime = doc.get('startTime');
        bool daily = doc.get('daily');
        if (isWithinCurrentWeek(startTime.toDate(), startOfWeek, endOfWeek) &&
            daily == false) {
          documentsToDelete.add(doc);
        }
      }

      for (var doc in documentsToDelete) {
        await doc.reference.delete();
      }
      await SherdPrefHelper().setDeletionDate(now.toIso8601String());
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isWithinCurrentWeek(
      DateTime date, DateTime startOfWeek, DateTime endOfWeek) {
    return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }
}
