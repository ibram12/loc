import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../auth/presentation/views/login_view.dart';
import '../../../../home/presentaiton/views/homePage.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  static const platform = MethodChannel('com.example.app/device_settings');

  SplashCubit() : super(SplashInitial());

  void checkInternetConectionAndAutoTimeSetting(BuildContext context) async {
    emit(SplashLoading()); 

    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isAutomaticTimeEnabled = await _checkAutomaticTimeSetting();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(SplashErrorState(() => checkInternetConectionAndAutoTimeSetting(context), true));
    } else if (!isAutomaticTimeEnabled) {
      emit(SplashErrorState(() => checkInternetConectionAndAutoTimeSetting(context), false));
    } else {
      _navigate(context);
    }
  }

  Future<bool> _checkAutomaticTimeSetting() async {
    try {
      final bool result = await platform.invokeMethod('isAutomaticTimeEnabled');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get time setting: '${e.message}'.");
      return false;
    }
  }

  void _navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      user == null
          ? Navigator.of(context).pushNamedAndRemoveUntil(LoginView.id, (route) => false)
          : Navigator.of(context).pushNamedAndRemoveUntil(MyHomePage.id, (route) => false);
    });
  }
}