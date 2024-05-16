import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'featch_avilable_halls_state.dart';

class FeatchAvilableHallsCubit extends Cubit<FeatchAvilableHallsState> {
  FeatchAvilableHallsCubit() : super(FeatchAvilableHallsInitial());

  Future<void> featchAvilableHallsDocs({
    required Timestamp startTime,
    required Timestamp endTime,
  }) async {
    emit(FeatchAvilableHallsLoading());

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
          bool conflict = startTime.toDate().isBefore(docEndTime.toDate()) &&
              endTime.toDate().isAfter(docStartTime.toDate());

          if (conflict) {
            hasConflict = true;
            break;
          }
        }

        if (!hasConflict) {
          availableHallsIds.add(doc.id);
        } else {}
      }

      emit(FeatchAvilableHallsLoaded(availableHallsIds));
    } catch (e) {
      emit(FeatchAvilableHallsError(message: e.toString()));
    }
  }
}
