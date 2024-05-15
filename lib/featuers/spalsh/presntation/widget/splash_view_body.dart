import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/auth/presentation/views/login_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    displayAnimation();
    navigate();
  }

  void displayAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: .5, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeIn));
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
        animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(kLogo))),
    );
  }

  navigate() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginView.id, (route) => false);
    });
  }
}
