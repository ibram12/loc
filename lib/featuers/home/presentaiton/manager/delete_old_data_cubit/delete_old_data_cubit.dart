import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../../core/functions/get_suterdat_of_the_curant_week.dart';

part 'delete_old_data_state.dart';

class DeleteOldDataCubit extends Cubit<DeleteOldDataState> {
  DeleteOldDataCubit() : super(DeleteOldDataInitial());

  Future<void> deleteOldData() async {
    DateTime now = DateTime.now();
    DateTime suterDay = getSuterDayOfCurrentWeek(now);
    if (kDebugMode) {
      print(suterDay);
    }
    CollectionReference myCollection =
        FirebaseFirestore.instance.collection('locs');
    QuerySnapshot snapshot = await myCollection.get();
    List<DocumentSnapshot> documentsToDelete = [];

    for (var hall in snapshot.docs) {
  await  myCollection.doc(hall.id).collection('reservations').get().then((reservationDocs)async {
        bool? daily;
        Timestamp? startTime;
        for (var doc in reservationDocs.docs) {
          try {
            daily =await doc.get('daily');
            startTime =await doc.get('startTime');
          } catch (e) {
            emit(DeleteOldDataerror());
          }
          if (daily == false && startTime!.toDate().isBefore(suterDay)) {
           documentsToDelete.add(doc); 
             for (var doc in documentsToDelete) {
              print("i deleted: ${doc.id}========================== because $startTime is before $suterDay and daily is $daily");
              await doc.reference.delete();
            } 
          }
        }
      });
    }
  }


}
