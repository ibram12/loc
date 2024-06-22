import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/functions/add_duration_7_days_on_the_time_methoud.dart';
import '../../../../../requests/data/models/user_request_model.dart';

part 'featch_avilable_halls_state.dart';

class FeatchAvilableHallsCubit extends Cubit<FeatchAvilableHallsState> {
  FeatchAvilableHallsCubit() : super(FeatchAvilableHallsInitial());

  Future<void> featchAvilableHallsDocs({
    required Timestamp startTime,
    required Timestamp endTime,
  }) async {
    emit(ThereNoAvilableHalls());

    try {
      var myHalls = await FirebaseFirestore.instance.collection('locs').get();
      List<String> availableHallsIds = [];

      for (var doc in myHalls.docs) {
        bool hasConflict = false;

        var reservations = await FirebaseFirestore.instance
            .collection('locs')
            .doc(doc.id)
            .collection('reservations')
            .get();

        for (var reservation in reservations.docs) {
          Timestamp docStartTime = reservation.get('startTime');
          Timestamp docEndTime = reservation.get('endTime');
          String replayState = reservation.get('replyState');
          bool daily = reservation.get('daily');

          if (daily == true) {
            List<DateTime> recurringDates = getWeeklyRecurringWhenFiltiringData(
                endDateCuruntMounth: docEndTime.toDate(),
                startDateCuruntMounth: docStartTime.toDate(),
                weeks: 9);
            print(recurringDates);
            for (int i = 0; i < recurringDates.length; i += 2) {
              DateTime recurringStart = recurringDates[i];
              DateTime recurringEnd = recurringDates[i + 1];

              if (startTime.toDate().isBefore(recurringEnd) &&
                  endTime.toDate().isAfter(recurringStart) &&
                  replayState != ReplyState.unaccepted.description) {
                hasConflict = true;
                break;
              }
            }
          } else {
            bool conflict = startTime.toDate().isBefore(docEndTime.toDate()) &&
                endTime.toDate().isAfter(docStartTime.toDate()) &&
                replayState != ReplyState.unaccepted.description;

            if (conflict) {
              hasConflict = true;
              break;
            }
          }
        }

        if (!hasConflict) {
          availableHallsIds.add(doc.id);
        }
      }

      if (availableHallsIds.isEmpty) {
        emit(ThereNoAvilableHalls());//TODO:here you can handle if there is no avilable halls
      } else {
        emit(FeatchAvilableHallsLoaded(availableHallsIds));
      }
    } catch (e) {
      emit(FeatchAvilableHallsError(message: e.toString()));
    }
  }
}
