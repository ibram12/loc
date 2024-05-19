import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/widgets/password_text_field.dart';
import 'package:loc/homePage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import '../../../../core/widgets/Custom_TextField.dart';
import '../manager/signUp_cubit/sign_up_cubit.dart';

import '../manager/signUp_cubit/sign_up_state.dart';
import '../../../auth/presentation/widgets/custom_logo_auth.dart';

class SginUpViewBody extends StatefulWidget {
  const SginUpViewBody({super.key});

  @override
  State<SginUpViewBody> createState() => _SginUpViewBodyState();
}

class _SginUpViewBodyState extends State<SginUpViewBody> {
  List<String> services = ['ملائكة', 'خدمة ابتدائي', 'خدمة ثانوي', 'اخرى'];
  List<String> roles = ['مشرف', 'مستخدم'];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  String service = 'Service';
  String role = 'Role';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        if (state is SignUpLoading) {
        } else if (state is SignUpSuccess) {
          email.clear();
          password.clear();
          name.clear();
          service = 'Service';
          role = 'Role';
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, 'Sign Up Successfully');
          });
        } else if (state is SignUpError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, state.message);
          });
        }
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const CustomLogoAuth(),
                    const SizedBox(height: 20),
                    const Text("Sign Up", style: Styles.textStyle30),
                    const SizedBox(height: 10),
                    const Text("Add New User", style: Styles.textStyle14),
                    const SizedBox(height: 10),
                    const Text(
                      "Name",
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hinttext: "ُYour Name", textEditingController: name),
                    const SizedBox(height: 10),
                    const Text(
                      "Email",
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hinttext: "ُEnter Your Email",
                        textEditingController: email),
                    const SizedBox(height: 10),
                    const Text(
                      "Password",
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    PasswordTextField(
                        onSaved: (value) {},
                        hinttext: 'Password',
                        textEditingController: password),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                            hint: Text(service),
                            items: services
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                service = value!;
                              });
                            }),
                        const SizedBox(height: 10),
                        DropdownButton(
                            hint: Text(role),
                            items: roles
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                role = value!;
                              });
                            }),
                      ],
                    ),
                    CustomBotton(
                        width: double.infinity,
                        backgroundColor: Colors.orange,
                        text: "Sign Up",
                        onPressed: () {
                          if (service == 'Service') {
                            showAlertDialog(
                                context: context,
                                message: 'please select service type',
                                onOkPressed: () {
                                  Navigator.pop(context);
                                });
                          } else if (role == 'Role') {
                            showAlertDialog(
                                context: context,
                                message: 'please select role type',
                                onOkPressed: () {
                                  Navigator.pop(context);
                                });
                          }
                          if (formKey.currentState!.validate() &&
                              role != 'Role' &&
                              service != 'Service') {
                            SherdPrefHelper().setUserName(name.text);
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpWithEmailAndPassword(
                              service: service,
                              role: role,
                              email: email.text,
                              password: password.text,
                              name: name.text,
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
