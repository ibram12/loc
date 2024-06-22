import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../requests/data/models/user_request_model.dart';

part 'featch_the_end_times_state.dart';

class FeatchTheEndTimesCubit extends Cubit<FeatchTheEndTimesState> {
  FeatchTheEndTimesCubit() : super(FeatchTheEndTimesInitial());

  Future<void> featchTheRemainingTime() async {
    emit(FeathTheEndTimesLoading());

    try {
      var myHalls = await FirebaseFirestore.instance.collection('locs').get();
      DateTime now = DateTime.now();

      for (var doc in myHalls.docs) {
      //  bool hasConflict = false;
        Duration? remainingTime;

        var reservations = await FirebaseFirestore.instance
            .collection('locs')
            .doc(doc.id)
            .collection('reservations')
            .get();

        for (var reservation in reservations.docs) {
          Timestamp docStartTime = await reservation.get('startTime');
          Timestamp docEndTime = await reservation.get('endTime');
          String replayState = await reservation.get('replyState');
          DateTime startTime = docStartTime.toDate();
          DateTime endTime = docEndTime.toDate();

          if (now.isBefore(endTime) &&
              now.isAfter(startTime) &&
              replayState == ReplyState.accepted.description) {
          //  hasConflict = true;
            remainingTime = endTime.difference(now);
            break;
          }
        }

        if (remainingTime != null) {
          emit(ThereWasReservationInTheCruntTime(doc.id, remainingTime));
        } else {
          emit(NoReservationInTheCruntTime(doc.id));
        }
      }
  //    emit(FeatchEndTimesIsDone());
    } catch (e) {
      if (!isClosed) {
        emit(FeatchTheEndTimesFailer(e.toString()));
      }
    }
  }
}
