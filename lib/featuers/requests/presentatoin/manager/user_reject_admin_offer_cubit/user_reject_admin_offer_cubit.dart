import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_reject_admin_offer_state.dart';

class UserRejectAdminOfferCubit extends Cubit<UserRejectAdminOfferState> {
  UserRejectAdminOfferCubit() : super(UserRejectAdminOfferInitial());
}
