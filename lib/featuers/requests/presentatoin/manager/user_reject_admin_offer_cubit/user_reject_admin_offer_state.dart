part of 'user_reject_admin_offer_cubit.dart';

@immutable
sealed class UserRejectAdminOfferState {}

final class UserRejectAdminOfferInitial extends UserRejectAdminOfferState {}

final class UserRejectAdminOfferSuccess extends UserRejectAdminOfferState {}

final class UserRejectAdminOfferLoading extends UserRejectAdminOfferState {}

final class UserRejectAdminOfferError extends UserRejectAdminOfferState {
  final String err;

  UserRejectAdminOfferError({required this.err});

}
