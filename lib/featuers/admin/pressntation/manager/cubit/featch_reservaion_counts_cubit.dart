import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'featch_reservaion_counts_state.dart';

class FeatchReservaionCountsCubit extends Cubit<FeatchReservaionCountsState> {
  FeatchReservaionCountsCubit() : super(FeatchReservaionCountsInitial());
  Future<void> fetchReservationsCounts() async {
    emit(FeatchReservaionCountsLoading());
      late Map<String, int> reservationsCounts = {};

    final halls = await FirebaseFirestore.instance.
    collection('locs').get();
    for (final hall in halls.docs) {
      final reservations = await FirebaseFirestore.instance
          .collection('locs')
          .doc(hall.id)
          .collection('reservations')
          .get();
      reservationsCounts[hall.id] = reservations.docs.length;
    }
    emit(FeatchReservaionCountsLoaded(reservationsCounts));
    
  }
}
