import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../requests/data/models/request_model.dart';

part 'add_request_state.dart';

class AddRequestCubit extends Cubit<AddRequestState> {
  AddRequestCubit() : super(AddRequestInitial());

  Future<void> addRequest(
      Timestamp startTime, Timestamp endTime, List<String> hallIds) async {
    emit(AddRequestLoading());
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;
      for (int i = 0; i < hallIds.length; i++) {
        String name = await FirebaseFirestore.instance
            .collection('locs')
            .doc(hallIds[i])
            .get()
            .then((value) {
          return value.data()!['name'];
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('requests')
            .add({
          'hallName': name,
          'startTime': startTime,// DateFormat('hh:mm a').format(startTime.toDate()),
          'endTime': endTime,// DateFormat('hh:mm a').format(endTime.toDate()),
          'replyState':
              ReplyState.noReplyYet.description, 
        });
      }

      emit(AddRequestSuccess());
    } catch (e) {
      emit(AddRequestFailure(error: e.toString()));
    }
  }
}
