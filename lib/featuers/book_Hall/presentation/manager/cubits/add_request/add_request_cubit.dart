import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../requests/data/models/request_model.dart';

part 'add_request_state.dart';

class AddRequestCubit extends Cubit<AddRequestState> {
  AddRequestCubit() : super(AddRequestInitial());

Future<String> addRequest(
    Timestamp startTime, Timestamp endTime, List<String> hallIds) async {
  emit(AddRequestLoading());
  try {
    String id = FirebaseAuth.instance.currentUser!.uid;
    String reservationId = '';
    for (int i = 0; i < hallIds.length; i++) {
      String name = await FirebaseFirestore.instance
          .collection('locs')
          .doc(hallIds[i])
          .get()
          .then((value) {
        return value.data()!['name'];
      });

      DocumentReference reservationRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('requests')
          .add({
        'hallName': name,
        'startTime': startTime,
        'endTime': endTime,
        'replyState': ReplyState.noReplyYet.description,
      });

      await reservationRef.set({
        'requestId': reservationRef.id,
        'hallName': name,
        'startTime': startTime,
        'endTime': endTime,
        'replyState': ReplyState.noReplyYet.description,
      });

      reservationId = reservationRef.id;
    }

    emit(AddRequestSuccess());
    return reservationId;
  } catch (e) {
    emit(AddRequestFailure(error: e.toString()));
    throw e; //TODO: HANLE THIS IN FUTURE
  }
}

}
