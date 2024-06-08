import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';
import '../../../../../generated/l10n.dart';
import 'show_user_requests_state.dart';

class ShowUserRequestsCubit extends Cubit<ShowUserRequestsState> {
  ShowUserRequestsCubit() : super(ShowUserRequestsState());

  final String id = FirebaseAuth.instance.currentUser!.uid;

  Future<void> fetchRequests(BuildContext context) async {
    try {
      emit(UserRequestsLoading());
      Query query = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('requests')
          .orderBy('startTime', descending: true);

      query.snapshots().listen(
        (snapshot) {
          _checkAndDeleteRequests(query);
          List<UserRequestModel> requests = snapshot.docs
              .map((doc) {
                try {
                  return UserRequestModel.fromDocumentSnapshot(doc);
                } catch (e) {
                  return null;
                }
              })
              .where((request) => request != null)
              .cast<UserRequestModel>()
              .toList();
          if (!isClosed) {
            emit(UserRequestsLoaded(requests));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserRequestsError(S.of(context).failed_to_fetch_requests));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserRequestsError(S.of(context).failed_to_fetch_requests));
      }
    }
  }

  Future<void> _checkAndDeleteRequests(Query query) async {
    try {
      DateTime now = DateTime.now();
      DateTime suterDay = getSuterDayOfCurrentWeek(now);
      print(suterDay);
    
    
        QuerySnapshot snapshot = await query.get();
        List<DocumentSnapshot> documentsToDelete = [];
        for (var doc in snapshot.docs) {
          bool? daily;
          Timestamp? startTime;
          try {
           startTime = doc.get('startTime');
            daily = doc.get('daily');
          } catch (e) {
            continue; // Skip this document if it has missing fields
          }
      //if condition to check if the start and daily is not null
          if (daily == false&&startTime!.toDate().isBefore(suterDay)) {
            documentsToDelete.add(doc);
            for (var doc in documentsToDelete) {
              await doc.reference.delete();
            }
          }
        }
      
    } catch (e) {
      print('Error in _checkAndDeleteRequests: $e');
    }
  }

DateTime getSuterDayOfCurrentWeek(DateTime date) {
  int daysSinceSuterDay = (date.weekday + 1) % 7; 
  DateTime suterDay = date.subtract(Duration(days: daysSinceSuterDay));
  return DateTime(suterDay.year, suterDay.month, suterDay.day);
}


}
