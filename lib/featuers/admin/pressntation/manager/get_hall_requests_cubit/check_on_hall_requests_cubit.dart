import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'check_on_hall_requests_state.dart';

class CheckOnRequestsCubit extends Cubit<CheckOnRequestsState> {
  CheckOnRequestsCubit() : super(CheckOnRequestsInitial());

  Future<void> checkAndDeleteRequests(Query query) async {
        DateTime now = DateTime.now();
      DateTime suterDay = getSuterDayOfCurrentWeek(now);
      print(suterDay);
        try {    
        QuerySnapshot snapshot = await query.get();
        List<DocumentSnapshot> documentsToDelete = [];
        for (var doc in snapshot.docs) {
          bool? daily;
          Timestamp? startTime;
          daily = doc.get('daily');
        startTime = doc.get('startTime');

          if (daily == false&&startTime!.toDate().isBefore(suterDay)) {
            documentsToDelete.add(doc);
            for (var doc in documentsToDelete) {
              await doc.reference.delete();
            }
          }
        }
    } catch (e) {
      print('Error in _checkAndDeleteRequests: $e');
      emit(CheckOnRequestsError(e.toString()));
    }
      }
    DateTime getSuterDayOfCurrentWeek(DateTime date) {
  int daysSinceSuterDay = (date.weekday + 1) % 7; 
  DateTime suterDay = date.subtract(Duration(days: daysSinceSuterDay));
  return DateTime(suterDay.year, suterDay.month, suterDay.day);
}
}
