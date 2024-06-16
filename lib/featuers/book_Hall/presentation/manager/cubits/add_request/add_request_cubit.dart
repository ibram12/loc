import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/server/shered_pref_helper.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../requests/data/models/user_request_model.dart';

part 'add_request_state.dart';

class AddRequestToUserCubit extends Cubit<AddRequestState> {
  AddRequestToUserCubit() : super(AddRequestInitial());

 Future <List<String>> addRequest(
    Timestamp startTime, Timestamp endTime, List<String> hallIds,bool daily,String selectedService) async {
  emit(AddRequestLoading());
  try {
    String id = FirebaseAuth.instance.currentUser!.uid;
  List<String> reservationId = [];
      String? isAdmin = await SherdPrefHelper().getUserRole();

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
        'hallId': hallIds[i],
        'hallName': name,
        'startTime': startTime,
        'endTime': endTime,
        'replyState': ReplyState.noReplyYet.description,
      });

      await reservationRef.set({
        'hallId': hallIds[i],
        'id': FirebaseAuth.instance.currentUser!.uid,
        'daily':daily,
        'requestId': reservationRef.id,
        'hallName': name,
        'startTime': startTime,
        'endTime': endTime,
        'replyState': isAdmin == kRoles[2] ? ReplyState.accepted.description : ReplyState.noReplyYet.description,
        'service': selectedService
      });

      reservationId.add(reservationRef.id);
    }

    emit(AddRequestSuccess());

    return reservationId;
  } catch (e) {
    emit(AddRequestFailure(error: e.toString()));
    throw e; //TODO: HANLE THIS IN FUTURE
  }
}

}
