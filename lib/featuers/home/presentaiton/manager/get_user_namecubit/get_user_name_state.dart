part of 'get_user_name_cubit.dart';

@immutable
sealed class GetUserNameState {}

final class GetUserNameInitial extends GetUserNameState {}
final class GetUserNameLoading extends GetUserNameState {}
final class GetUserNameSuccess extends GetUserNameState {
    final String? userName;

    GetUserNameSuccess({ this.userName});
  }