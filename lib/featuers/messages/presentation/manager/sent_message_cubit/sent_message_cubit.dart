import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:meta/meta.dart';

import '../../../data/models/chat_buble_model.dart';

part 'sent_message_state.dart';

class SentMessageCubit extends Cubit<SentMessageState> {
  SentMessageCubit() : super(SentMessageInitial());
  Future<void> sentMessage({required String message}) async {
    emit(SentMessageLoading());
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('messages')
        .add({"message": message, "time": DateTime.now(), "id": id,"isSent":true});
    var myBox =await Hive.openBox(kMessagesBox);
    myBox.add(ChatBubleModel(id: id, massege: message, time: DateTime.now(),isSent: false));
    emit(SentMessageSuccess());
  }
}
