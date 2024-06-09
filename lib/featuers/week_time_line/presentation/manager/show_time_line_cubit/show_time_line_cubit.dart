import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:meta/meta.dart';

import '../../../data/models/reservation_info_model.dart';
import '../../../data/models/reservation_model.dart';

part 'show_time_line_state.dart';

class ShowTimeLineCubit extends Cubit<ShowTimeLineState> {
  ShowTimeLineCubit() : super(ShowTimeLineInitial());

  Future<void> getTheTimeLine({required String hallName}) async {
    List<Meeting> meetings = [];
    emit(ShowTimeLineLoading());

    print("$hallName in the cubit=========");
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

          List<Meeting> locMeetings = reservationsSnap.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            ReservatoinModel reservation =
                ReservatoinModel.fromDoucumentSnapshot(data);
            return Meeting.fromReservatoinModel(reservation, doc.id, name);
          }).toList();

          meetings.addAll(locMeetings);
        }
      }
      emit(ShowTimeLineSuccess(meetings));
    } catch (e) {
      emit(ShowTimeLineError(e.toString()));
    }
  }
}
