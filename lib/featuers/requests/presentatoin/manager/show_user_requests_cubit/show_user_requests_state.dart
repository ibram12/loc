


 class ShowUserRequestsState {}


class UserRequestsInitial extends ShowUserRequestsState {}

class UserRequestsLoading extends ShowUserRequestsState {}
 
 class DeleteOldRequestsDone extends ShowUserRequestsState {}
class UserRequestsError extends ShowUserRequestsState {
  final String message;

  UserRequestsError(this.message);
}