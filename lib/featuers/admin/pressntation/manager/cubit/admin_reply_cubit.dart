import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'admin_reply_state.dart';

class AdminReplyCubit extends Cubit<AdminReplyState> {
  AdminReplyCubit() : super(AdminReplyInitial());
  Future <void> adminReply({required String id})async{
    emit(AdminReplyLoading());
     //FirebaseFirestore.instance.collection('users').doc(id).collection()
  }
}
