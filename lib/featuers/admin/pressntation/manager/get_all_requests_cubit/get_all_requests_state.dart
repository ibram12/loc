part of 'get_all_requests_cubit.dart';

@immutable
sealed class GetAllRequestsState {}

final class GetAllRequestsInitial extends GetAllRequestsState {}

final class GetAllHallsNameLoading extends GetAllRequestsState {}

final class GetAllHallsRequestsDone extends GetAllRequestsState {
  final List<String> allHallsNames;
  final List<String> allHallRequests;

  GetAllHallsRequestsDone(this.allHallsNames, this.allHallRequests);
}

final class GetAllHallsNameFailer extends GetAllRequestsState {
  final String massege;

  GetAllHallsNameFailer(this.massege);
}

final class GetAllHallReservaionsLoading extends GetAllRequestsState {}

final class GetAllHallReservationsDone extends GetAllRequestsState {


}

final class GetAllHallReservaionsFailer extends GetAllRequestsState {
  final String massege;

  GetAllHallReservaionsFailer(this.massege);

}


