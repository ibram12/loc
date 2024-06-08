import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'get_hall_requests_state.dart';

class GetHallRequestsCubit extends Cubit<GetHallRequestsState> {
  GetHallRequestsCubit() : super(GetHallRequestsInitial());

  Future<void> checkAndDeleteRequests(Query query) async {
    try {
      String? lastDeletionDateStr;
      DateTime now = DateTime.now();
    await  FirebaseFirestore.instance  //in this case you have learned how much await keyword is very important
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
          daily = doc.get('daily');
          if (daily == false) {
            documentsToDelete.add(doc);
            for (var doc in documentsToDelete) {
              await doc.reference.delete();
            }
          }
        }
        await FirebaseFirestore.instance
            .collection('admin')
            .doc('deletionDate')
            .update({'lastDeletionDate': now.toString()});
      }
    } catch (e) {
      emit(GetHallRequestsError(e.toString()));
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
