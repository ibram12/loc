import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/auth/presentation/views/login_view.dart';
import 'package:loc/core/views/error_view.dart';
import 'package:loc/featuers/home/presentaiton/views/homePage.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  static const platform = MethodChannel('com.example.app/device_settings');

  @override
  void initState() {
    super.initState();
    displayAnimation();
    checkInternetConectionAndAutoTimeSetting();
  }

  void displayAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: .5, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
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

  Future<void> checkInternetConectionAndAutoTimeSetting() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isAutomaticTimeEnabled = await checkAutomaticTimeSetting();
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ErrorView(
          onRetry: checkInternetConectionAndAutoTimeSetting,
          visable: true,
        ),
      ));
    } else if (!isAutomaticTimeEnabled) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ErrorView(
          onRetry: checkInternetConectionAndAutoTimeSetting,
          visable: false,
        ),
      ));
    } else {
      navigate();
    }
  }

  Future<bool> checkAutomaticTimeSetting() async {
    try {
      final bool result = await platform.invokeMethod('isAutomaticTimeEnabled');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get time setting: '${e.message}'.");
      return false;
    }
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      user == null
          ? Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginView.id, (route) => false)
          : Navigator.of(context)
              .pushNamedAndRemoveUntil(MyHomePage.id, (route) => false);
    });
  }
}
