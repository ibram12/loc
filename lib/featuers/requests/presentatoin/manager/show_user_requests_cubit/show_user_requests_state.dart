

import '../../../data/models/user_request_model.dart';

 class ShowUserRequestsState {}


class UserRequestsInitial extends ShowUserRequestsState {}

class UserRequestsLoading extends ShowUserRequestsState {}

class UserRequestsLoaded extends ShowUserRequestsState {
  final List<UserRequestModel> requests;

  UserRequestsLoaded(this.requests);
}

class UserRequestsError extends ShowUserRequestsState {
  final String message;

  UserRequestsError(this.message);
}