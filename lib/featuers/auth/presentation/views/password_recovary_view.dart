import 'package:flutter/material.dart';

import '../widgets/password_recovary_view_body.dart';

class PasswordRecoveryVeiw extends StatelessWidget {
  const PasswordRecoveryVeiw({super.key});
  static String id = 'PasswordRecoveryVeiw';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 109, 106, 106),
      body: PasswordRecavoryBody(),
    );
  }
}