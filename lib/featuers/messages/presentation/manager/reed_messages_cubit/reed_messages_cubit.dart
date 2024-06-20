import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loc/core/functions/get_suterdat_of_the_curant_week.dart';
import 'package:meta/meta.dart';

part 'reed_messages_state.dart';

class DeleteOldMessagesCubit extends Cubit<ReedMessagesState> {
  DeleteOldMessagesCubit() : super(ReedMessagesInitial());
  
  Future<void> featchOldMessges() async {
    emit(ReedMessagesLoading());
    CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection("messages");
    QuerySnapshot messages = await messagesCollection.get();
    List<DocumentSnapshot> messagesToDelete = [];
    DateTime suterDayOfTheCurantWeek = getSuterDayOfCurrentWeek(DateTime.now());

    for (var message in messages.docs) {
      Timestamp sentTime = message['time'];
      if (sentTime.toDate().isBefore(suterDayOfTheCurantWeek)) {
        messagesToDelete.add(message);
        for (var message in messagesToDelete) {
          await message.reference.delete();
        }
      }
    }

    emit(ReedMessagesSuccess());
  }
}
