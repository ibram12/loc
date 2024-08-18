import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../core/server/shered_pref_helper.dart';

part 'get_user_name_state.dart';

class GetUserNameCubit extends Cubit<GetUserNameState> {
  GetUserNameCubit() : super(GetUserNameInitial());

  Future<void> getUserName() async {
    emit(GetUserNameLoading());
    String? userName = await SherdPrefHelper().getUserName();

    if (userName == null) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userInfo =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      emit(GetUserNameSuccess(userName: userInfo['name']));
      await SherdPrefHelper().setUserName(userInfo['name']);
    } else {
      emit(GetUserNameSuccess(userName: userName));
    }
  }
}
