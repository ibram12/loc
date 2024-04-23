import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/auth/presentation/manager/cubits/logIn_cubit/log_in_cubit.dart';
import 'package:loc/featuers/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String id = "LoginView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: const Scaffold(body: LogInViewBody()),
    );
  }
}
