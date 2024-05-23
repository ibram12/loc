import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:lottie/lottie.dart';

import '../text_styles/Styles.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onRetry, required this.visable});
  static String id = 'ErrorView';
  final VoidCallback onRetry;
  final bool visable;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Visibility(
            visible: visable,
            child: Lottie.asset('assets/animations/Animation - 1716081356717.json')),
          visable? const  Text('Please Check Your Internet Connection',style: Styles.textStyle20,):const Text('Please enable automatic time in your device settings.',style: Styles.textStyle20,),
           CustomBotton(
            onPressed: onRetry,
            backgroundColor: kOrange,
            text: 'retry?')
          ],
        ),
      ),
    );
  }
}
