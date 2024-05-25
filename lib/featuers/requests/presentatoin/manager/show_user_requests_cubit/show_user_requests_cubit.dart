import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';

import '../../../../../core/server/shered_pref_helper.dart';
import 'show_user_requests_state.dart';

class ShowUserRequestsCubit extends Cubit<ShowUserRequestsState> {
  ShowUserRequestsCubit() : super(ShowUserRequestsState());

  String id = FirebaseAuth.instance.currentUser!.uid;
  Future<void> featchRequests() async {
    try {
  emit(UserRequestsLoading());
  Query query = FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .collection('requests')
      .orderBy('replyState', descending: true);
  
  query.snapshots().listen((snapshot) {
    _checkAndDeleteRequests(query);
    List<UserRequestModel> requests = snapshot.docs
        .map((doc) => UserRequestModel.fromDocumentSnapshot(doc))
        .toList();
      
    emit(UserRequestsLoaded(requests));
  });
}  catch (e) {
  emit(UserRequestsError('Failed to fetch requests'));
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
