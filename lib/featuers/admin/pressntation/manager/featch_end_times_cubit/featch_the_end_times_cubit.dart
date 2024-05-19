import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'featch_the_end_times_state.dart';

class FeatchTheEndTimesCubit extends Cubit<FeatchTheEndTimesState> {
  FeatchTheEndTimesCubit() : super(FeatchTheEndTimesInitial());

  Future<void> featchTheRemainingTime() async {
    emit(FeathTheEndTimesLoading());

    try {
      var myHalls = await FirebaseFirestore.instance.collection('locs').get();
      DateTime now = DateTime.now();

      for (var doc in myHalls.docs) {
        bool hasConflict = false;
        Duration? remainingTime;

        var reservations = await FirebaseFirestore.instance
            .collection('locs')
            .doc(doc.id)
            .collection('reservations')
            .get();

        for (var reservation in reservations.docs) {
          Timestamp docStartTime = reservation.get('startTime');
          Timestamp docEndTime = reservation.get('endTime');
          DateTime startTime = docStartTime.toDate();
          DateTime endTime = docEndTime.toDate();

          if (now.isBefore(endTime) && now.isAfter(startTime)) {
            hasConflict = true;
            remainingTime = endTime.difference(now);
            break;
          }
        }

        if (hasConflict && remainingTime != null) {
          emit(ThereWasReservationInTheCruntTime(doc.id,remainingTime));
          print(remainingTime.toString());
        } else {
          emit(NoReservationInTheCruntTime(doc.id));
        }
      }
    } catch (e) {
      emit(FeatchTheEndTimesFailer(e.toString()));
    }
  }
}
