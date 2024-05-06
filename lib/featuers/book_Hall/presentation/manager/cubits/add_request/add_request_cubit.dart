import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../requests/data/models/request_model.dart';

part 'add_request_state.dart';

class AddRequestCubit extends Cubit<AddRequestState> {
  AddRequestCubit() : super(AddRequestInitial());

  Future<void> addRequest(UserRequestModel requestModel) async {
    emit(AddRequestLoading());
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('requests')
          .add({
        'hallName': requestModel.hallName,
        'startTime': requestModel.startTime,
        'endTime': requestModel.endTime,
        'replyState': requestModel.replyState.toString(),
      });
      emit(AddRequestSuccess());
    } catch (e) {
      emit(AddRequestFailure(error: e.toString()));
    }
  }
}
