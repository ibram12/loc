import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/alert_dalog.dart';
import '../../../../core/helper/dialog_with_textFiald.dart';
import '../../../../core/widgets/custom_botton.dart';
import '../../../../generated/l10n.dart';
import '../manager/signUp_cubit/sign_up_cubit.dart';

class SginUpButtom extends StatelessWidget {
const   SginUpButtom({
    super.key,
    required this.services,
    required this.role,
    required this.formKey,
    required this.signUpController,
    required this.signUpKey,
    required this.email,
    required this.password,
    required this.name,
  });

  final List<String> services;
  final String role;
  final GlobalKey<FormState> formKey;
  final TextEditingController signUpController;
  final GlobalKey<FormState> signUpKey;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return CustomBotton(
        width: double.infinity,
        backgroundColor: Colors.orange,
        text: S.of(context).sign_up,
        onPressed: () {
          if (services.isEmpty) {
            showAlertDialog(
                context: context,
                message: S.of(context).please_select_service,
                onOkPressed: () {
                  Navigator.pop(context);
                });
          } else if (role == 'Role') {
            showAlertDialog(
                context: context,
                message:
                    S.of(context).please_select_role_type,
                onOkPressed: () {
                  Navigator.pop(context);
                });
          }
          if (formKey.currentState!.validate() &&
              role != 'Role' &&
              services.isNotEmpty) {
            showTextFieldDialog(context, signUpController,
                () async {
              if (signUpKey.currentState!.validate()) {
                await BlocProvider.of<SignUpCubit>(context)
                    .createUserWithEmailAndPassword(
                  context: context,
                  services: services,
                  role: role,
                  email: email.text,
                  userpassword: password.text,
                  adminPassword: signUpController.text,
                  name: name.text,
                );
              }
            },
                signUpKey,
                S.of(context).enter_admin_password,
                S.of(context).admin_password,
                S.of(context).admin_password,
                true);
          }
        });
  }
}
