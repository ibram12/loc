import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';

import '../../../data/models/reservation_info_model.dart';
import '../../../data/models/reservation_model.dart';

part 'show_time_line_state.dart';

class ShowTimeLineCubit extends Cubit<ShowTimeLineState> {
  ShowTimeLineCubit() : super(ShowTimeLineInitial());

  Future<void> getTheTimeLine({required String hallName}) async {
    List<Meeting> meetings = [];
    emit(ShowTimeLineLoading());

    try {
      QuerySnapshot locations =
          await FirebaseFirestore.instance.collection('locs').get();
      for (var loc in locations.docs) {
        String name = loc['name'];

        if (hallName == 'all Halls' || hallName == name) {
          QuerySnapshot reservationsSnap = await FirebaseFirestore.instance
              .collection('locs')
              .doc(loc.id)
              .collection('reservations')
              .where('replyState',
                  isNotEqualTo: ReplyState.unaccepted.description)
              .get();

          for (var doc in reservationsSnap.docs) {
            var data = doc.data() as Map<String, dynamic>;
            ReservatoinModel reservation =
                ReservatoinModel.fromDoucumentSnapshot(data);

            if (doc['daily'] == true) {
              DateTime now = DateTime.now();
              DateTime startDate = (doc['startTime'] as Timestamp).toDate();
              List<DateTime> recurringDates =
                  getWeeklyRecurringDates(DateTime(now.year, now.month, startDate.day), 4);
              for (DateTime date in recurringDates) {
                var newReservationData = Map<String, dynamic>.from(data);
                newReservationData['startTime'] = Timestamp.fromDate(date);

                Meeting meeting = Meeting.fromReservatoinModel(
                    ReservatoinModel.fromDoucumentSnapshot(newReservationData),
                    doc.id,
                    hallName);
                meetings.add(meeting);
              }
            } else {
              // إذا لم يكن الحجز يومي، فقط أضف الحجز كالمعتاد
              Meeting meeting =
                  Meeting.fromReservatoinModel(reservation, doc.id, name);
              meetings.add(meeting);
            }
          }
        }
      }
      emit(ShowTimeLineSuccess(meetings));
    } catch (e) {
      emit(ShowTimeLineError(e.toString()));
    }
  }
}

List<DateTime> getWeeklyRecurringDates(DateTime startDate, int weeks) {
  List<DateTime> dates = [];
  for (int i = 0; i < weeks; i++) {
    dates.add(startDate.add(Duration(days: 7 * i)));
  }
  return dates;
}
