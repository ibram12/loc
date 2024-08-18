import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/functions/get_suterdat_of_the_curant_week.dart';
import '../../../data/models/user_request_model.dart';
import 'show_user_requests_state.dart';

class ShowUserRequestsCubit extends Cubit<ShowUserRequestsState> {
  ShowUserRequestsCubit() : super(ShowUserRequestsState());

  final String id = FirebaseAuth.instance.currentUser!.uid;

  Future<void> checkAndDeleteRequests() async {
    try {
      emit(UserRequestsLoading());
      DateTime now = DateTime.now();
      DateTime suterDay = getSuterDayOfCurrentWeek(now);
      Query query = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('requests');

      QuerySnapshot snapshot = await query.get();
      List<DocumentSnapshot> documentsToDelete = [];
      for (var doc in snapshot.docs) {
        bool? daily;
        Timestamp? startTime;
    
          startTime = doc.get('startTime');
          daily = doc.get('daily');
        
        if (daily == false && startTime!.toDate().isBefore(suterDay)|| doc.get('replyState') == ReplyState.unaccepted.description) {
          documentsToDelete.add(doc);
          for (var doc in documentsToDelete) {
            await doc.reference.delete();
          }
        }
      }

      emit(DeleteOldRequestsDone());
    } catch (e) {
      emit(UserRequestsError(e.toString()));
      if (kDebugMode) {
        print('Error in _checkAndDeleteRequests: $e');
      }
    }
  }
}
