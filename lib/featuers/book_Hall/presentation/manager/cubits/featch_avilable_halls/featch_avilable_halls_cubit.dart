import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'featch_avilable_halls_state.dart';

class FeatchAvilableHallsCubit extends Cubit<FeatchAvilableHallsState> {
  FeatchAvilableHallsCubit() : super(FeatchAvilableHallsInitial());

  Stream<List<QueryDocumentSnapshot>> getAvilableHalls({
    required Timestamp startTime,
    required Timestamp endTime,
  }) async* {
    emit(FeatchAvilableHallsLoading());

    try {
      // Query for reservations that overlap with the specified time range
      QuerySnapshot overlappingReservations = await FirebaseFirestore.instance
          .collection('locs')
          .where('reservations.startTime', isLessThan: endTime)
          .where('reservations.endTime', isGreaterThan: startTime)
          .get();

      // Get the IDs of halls with overlapping reservations
      List<String> hallIdsWithReservations = overlappingReservations.docs
          .map((doc) => doc['hallId'] as String)
          .toList();

      // Query for all halls
      Stream<QuerySnapshot> allHallsStream = FirebaseFirestore.instance
          .collection('locs')
          .snapshots();

      await for (QuerySnapshot allHallsSnapshot in allHallsStream) {
        // Filter out halls with reservations overlapping with the specified time range
        List<QueryDocumentSnapshot> availableHalls = allHallsSnapshot.docs
            .where((hall) => !hallIdsWithReservations.contains(hall.id))
            .toList();

        yield availableHalls;
      }
    } catch (error) {
      emit(FeatchAvilableHallsError(message: error.toString()));
    }
  }
}
