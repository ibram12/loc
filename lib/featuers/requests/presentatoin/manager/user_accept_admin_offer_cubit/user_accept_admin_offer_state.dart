part of 'user_accept_admin_offer_cubit.dart';

@immutable
sealed class UserAcceptAdminOfferState {}

final class UserAcceptAdminOfferInitial extends UserAcceptAdminOfferState {}

final class UserAcceptAdminOfferSuccess extends UserAcceptAdminOfferState {}

final class UserAcceptAdminOfferLoading extends UserAcceptAdminOfferState {}

final class UserAcceptAdminOfferError extends UserAcceptAdminOfferState {
  final String err;

  UserAcceptAdminOfferError({required this.err});
}
