import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'modify_permissions_state.dart';

class ModifyPermissionsCubit extends Cubit<ModifyPermissionsState> {
  ModifyPermissionsCubit() : super(ModifyPermissionsInitial());

  Future<void> modifyServicePermissions(
      {required String userId, required List modifiedServices}) async {
  emit(ModifyPermissionsLoading());
  await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'service': modifiedServices}).catchError(
      (error) => emit(ModifyPermissionsError('something went wrong , please try later')),
        );
    emit(ModifyServicePermissionsSuccess());
  }

  Future<void> modifyRolePermissions({required String userId, required String selectedRole}) async {
      emit(ModifyPermissionsLoading());
  await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'role': selectedRole}).catchError(
      (error) => emit(ModifyPermissionsError('something went wrong , please try later')),
        );
    emit(ModifyRolePermissionsSuccess());
  }
}
