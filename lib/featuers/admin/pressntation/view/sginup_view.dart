import 'package:flutter/material.dart';

import '../widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const String id = "SignUpView";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SginUpViewBody(),
    );
  }
}
