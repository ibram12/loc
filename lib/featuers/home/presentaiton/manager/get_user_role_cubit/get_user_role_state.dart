part of 'get_user_role_cubit.dart';

@immutable
sealed class GetUserRoleState {}

final class GetUserRoleInitial extends GetUserRoleState {}

final class GetUserRoleLoading extends GetUserRoleState {}

final class GetUserRoleSuccess extends GetUserRoleState {
  final String? userRole;

  GetUserRoleSuccess({required this.userRole});

}

