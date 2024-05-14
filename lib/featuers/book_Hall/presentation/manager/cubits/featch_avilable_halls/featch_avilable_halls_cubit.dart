import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'featch_avilable_halls_state.dart';

class FeatchAvilableHallsCubit extends Cubit<FeatchAvilableHallsState> {
  FeatchAvilableHallsCubit() : super(FeatchAvilableHallsInitial());

  Future<void> featchAvilableHallsDocs() async {
    var myHalls = await FirebaseFirestore.instance.collection('locs').get();

    myHalls.docs.forEach((doc) async {
      // Access each document here
      var documentData = doc.data();
      //  return documentData['hallId'];
      var documentId = doc.id;
        
      var reservatoins =    await FirebaseFirestore.instance
          .collection('locs')
          .doc(documentId)
          .collection('reservations')
          .where('replyState', isEqualTo: 'Accepted')
          .get();
      for (var hall in reservatoins.docs) {
      
      }
     
    });
  }
}
