import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

import '../widget/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: 
    Scaffold(
      body: Container(
        
        decoration:  BoxDecoration(
        color:  kOrange,
           gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
             Colors.orange.shade300, 
              Colors.orange.shade800, 
           ])
        ),
        child: const SplashViewBody(),
      ),
    ));
  }
}