import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'featch_avilable_halls_state.dart';

class FeatchAvilableHallsCubit extends Cubit<FeatchAvilableHallsState> {
  FeatchAvilableHallsCubit() : super(FeatchAvilableHallsInitial());
Future<List<QueryDocumentSnapshot>> getAvilableHalls({
  required Timestamp startTime,
  required Timestamp endTime,
}) async {
  emit(FeatchAvilableHallsLoading());
  List<QueryDocumentSnapshot> availableHalls = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('locs').get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
    bool isHallAvailable = true;

    if (doc.data().containsKey('reservations')) {
      List<dynamic> reservations = doc.data()['reservations'];

      for (dynamic reservation in reservations) {
        Timestamp reservationStartTime = reservation['startTime'];
        Timestamp reservationEndTime = reservation['endTime'];

        // Check if the reservation overlaps with the provided time range
        if ((reservationStartTime.compareTo(endTime) < 0 &&
                reservationEndTime.compareTo(startTime) > 0) ||
            (reservationStartTime.compareTo(startTime) == 0 &&
                reservationEndTime.compareTo(endTime) == 0)) {
          isHallAvailable = false;
          break; // Exit the loop if an overlapping reservation is found
        }
      }
    }

    if (isHallAvailable) {
      availableHalls.add(doc);
    }
  }

  if (availableHalls.isEmpty) {
    emit(FeatchAvilableHallsError(
        message: 'Oops, there are no available halls for this time range'));
  } else {
    emit(FeatchAvilableHallsSuccess(docs: availableHalls));
  }

  return availableHalls;
}

}
