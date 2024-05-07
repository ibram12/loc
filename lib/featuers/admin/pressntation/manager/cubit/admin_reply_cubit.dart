import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'admin_reply_state.dart';

class AdminReplyCubit extends Cubit<AdminReplyState> {
  AdminReplyCubit() : super(AdminReplyInitial());
  Future<void> adminReplyAccept({required String hallid, required String userId,required String requestId}) async {
    emit(AdminReplyLoading());
    FirebaseFirestore.instance.collection('locs').doc(hallid).collection('reservations').doc(userId).update({'replyState': 'Accept'});
    FirebaseFirestore.instance.collection('users').doc(userId).collection('requests').doc(requestId).update({'replyState': 'Accept'});
    emit(AdminReplyAccept());
  }
  Future<void> adminReplyReject({required String hallid, required String docid}) async {
    
  }
}
