import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'modify_permissions_state.dart';

class ModifyPermissionsCubit extends Cubit<ModifyPermissionsState> {
  ModifyPermissionsCubit() : super(ModifyPermissionsInitial());

  Future<void> modifyServicePermissions(
      {required String userId, required List modifiedServices, required BuildContext context}) async {
  emit(ModifyPermissionsLoading());
  await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'service': modifiedServices}).catchError(
      (error) => emit(ModifyPermissionsError(S.of(context).something_went_wrong_please_try_later)),
        );
    emit(ModifyServicePermissionsSuccess());
  }

  Future<void> modifyRolePermissions({required String userId, required String selectedRole, required BuildContext context}) async {
      emit(ModifyPermissionsLoading());
  await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'role': selectedRole}).catchError(
      (error) => emit(ModifyPermissionsError(S.of(context).something_went_wrong_please_try_later)),
        );
    emit(ModifyRolePermissionsSuccess());
  }
}
