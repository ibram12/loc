import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_hall_requests_state.dart';

class GetHallRequestsCubit extends Cubit<GetHallRequestsState> {
  GetHallRequestsCubit() : super(GetHallRequestsInitial());
}
