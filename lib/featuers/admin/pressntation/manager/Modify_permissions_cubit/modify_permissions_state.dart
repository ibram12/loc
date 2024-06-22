part of 'modify_permissions_cubit.dart';

@immutable
sealed class ModifyPermissionsState {}

final class ModifyPermissionsInitial extends ModifyPermissionsState {}
final class ModifyPermissionsLoading extends ModifyPermissionsState {}
final class ModifyServicePermissionsSuccess extends ModifyPermissionsState {}
final class ModifyRolePermissionsSuccess extends ModifyPermissionsState {}
final class ModifyPermissionsError extends ModifyPermissionsState {
  final String message;
  ModifyPermissionsError(this.message);
}
