import 'package:flutter/material.dart';
import 'package:loc/featuers/auth/presentation/widgets/login_view_body.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});
 static const String id = "LoginView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LogInViewBody()
    );
  }
}
