import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../core/server/shered_pref_helper.dart';
import '../../../../../core/utils/constants.dart';

part 'get_user_role_state.dart';

class GetUserRoleCubit extends Cubit<GetUserRoleState> {
  GetUserRoleCubit() : super(GetUserRoleInitial());

  Future<void> getUserRole() async {
    emit(GetUserRoleLoading());
    if (await SherdPrefHelper().getUserRole() == null) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userInfo =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (userInfo['role'] == kRoles[2]) {
      emit(GetUserRoleSuccess(userRole: kRoles[2]));
        await SherdPrefHelper().setUserRole(kRoles[2]);
      } else if (userInfo['role'] == kRoles[1]) {
      emit(GetUserRoleSuccess(userRole: kRoles[1]));
        await SherdPrefHelper().setUserRole(kRoles[1]);
      } else {
      emit(GetUserRoleSuccess(userRole: kRoles[0]));
        await SherdPrefHelper().setUserRole(kRoles[0]);
      }
    } else {
      String? userRole = await SherdPrefHelper().getUserRole();
      emit(GetUserRoleSuccess(userRole: userRole));
    }
  }
}
