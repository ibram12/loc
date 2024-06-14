import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'get_all_requests_state.dart';

class GetAllRequestsCubit extends Cubit<GetAllRequestsState> {
  GetAllRequestsCubit() : super(GetAllRequestsInitial());

  Future<void> getHallsRequests() async {
    List<String> hallsWithReservationsNames = [];
    List<String> hallsWithReservationsIds = [];
    emit(GetAllHallsNameLoading());
    QuerySnapshot locs =
        await FirebaseFirestore.instance.collection("locs").get();

    for (var loc in locs.docs) {
      if (await FirebaseFirestore.instance
              .collection("locs")
              .doc(loc.id)
              .collection("reservations")
              .get()
              .then((value) => value.docs.isNotEmpty)) {
        String name = loc['name'];
        hallsWithReservationsNames.add(name);
        emit(GetAllHallReservaionsLoading());
        hallsWithReservationsIds.add(loc.id);
        emit(GetAllHallsRequestsDone(hallsWithReservationsIds,hallsWithReservationsNames));
      } else {}
    }
    if (hallsWithReservationsNames.isEmpty) {
      emit(GetAllHallsNameFailer('no requests found'));
    }else if(hallsWithReservationsIds.isEmpty){
      emit(GetAllHallReservaionsFailer('no requests found'));
    }
  }
}
