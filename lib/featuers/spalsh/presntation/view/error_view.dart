import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onRetry});
  static String id = 'ErrorView';
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Lottie.asset('assets/animations/Animation - 1716081356717.json'),
          
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
