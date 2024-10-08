import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/pressntation/manager/signUp_cubit/sign_up_cubit.dart';

import '../widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const String id = "SignUpView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const Scaffold(
        body: SginUpViewBody(),
      ),
    );
  }
}
