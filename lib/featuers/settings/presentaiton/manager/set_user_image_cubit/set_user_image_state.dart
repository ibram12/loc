part of 'set_user_image_cubit.dart';

@immutable
sealed class SetUserImageState {}

final class SetUserImageInitial extends SetUserImageState {}

final class SetUserImageLoading extends SetUserImageState {}

final class SetUserImageSuccess extends SetUserImageState {
  final String imageUrl;
  SetUserImageSuccess({required this.imageUrl});
}

final class SetUserImageError extends SetUserImageState {
  final String error;
  SetUserImageError({required this.error});
}
