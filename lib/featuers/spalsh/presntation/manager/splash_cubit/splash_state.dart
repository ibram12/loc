part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashErrorState extends SplashState {
  final VoidCallback onRetry;
  final bool visible;

  SplashErrorState(this.onRetry, this.visible);
}