import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';
import '../../../../../core/server/shered_pref_helper.dart';
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

      String? lastDeletionDateStr =
          await SherdPrefHelper().getLastDeletionDate();
      DateTime lastDeletionDate = lastDeletionDateStr != null
          ? DateTime.parse(lastDeletionDateStr)
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
            await SherdPrefHelper().setDeletionDate(now.toIso8601String());
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
