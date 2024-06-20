import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/views/error_view.dart';

import '../manager/splash_cubit/splash_cubit.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _splashCubit = context.read<SplashCubit>();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: .5, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.repeat(reverse: true);

    _splashCubit.checkInternetConectionAndAutoTimeSetting(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashLoading) {
          return FadeTransition(
            opacity: _animation,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(400),
                child: Image.asset(
                  kLogo,
                  fit: BoxFit.fill,
                   height: MediaQuery.of(context).size.height * .38,
                ),
              ),
            ),
          );
        } else if (state is SplashErrorState) {
          return ErrorView(
            onRetry: state.onRetry,
            visable: state.visible,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
