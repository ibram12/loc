import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../text_styles/Styles.dart';

class ErrorView extends StatefulWidget {
  const ErrorView({super.key, required this.onRetry, required this.visable});
  static String id = 'ErrorView';
  final VoidCallback onRetry;
  final bool visable;

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  bool isLoading = false;
void  onRetry()async {
    setState(() {
      isLoading = true;
    });
    try{
  
       widget.onRetry();
       await Future.delayed(const Duration(seconds: 3));
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Visibility(
                    visible: widget.visable,
                    child: Lottie.asset(
                        'assets/animations/Animation - 1716081356717.json')),
              ),
              widget.visable
                  ? const Text(
                      'Please Check Your Internet Connection',
                      style: Styles.textStyle20,
                    )
                  : const Text(
                      'Please enable automatic time in your device settings ⚙ , then try again!',
                      style: Styles.textStyle20,
                    ),
              CustomBotton(
                  onPressed: onRetry,
                  backgroundColor: kOrange,
                  text: 'retry?')
            ],
          ),
        ),
      ),
    );
  }
}
