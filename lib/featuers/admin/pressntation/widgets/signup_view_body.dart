import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
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
        isLoading = true;
      } else if (state is SignUpSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, MyHomePage.id, (route) => false);
          showSnackBar(context, 'Sign Up Successfully');
        });
      } else if (state is SignUpError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSnackBar(context, state.message);
        });
          isLoading = false;

      }
        return ModalProgressHUD(
          inAsyncCall: isLoading,
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
                    const Text("Add New User",
                        style: Styles.textStyle14),
                    const SizedBox(height: 10),
                    const Text(
                      "Name",
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hinttext: "ُYour Name",
                        textEditingController: name),
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
                    CustomBotton(
                        width: double.infinity,
                        backgroundColor: Colors.orange,
                        text: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                           SherdPrefHelper().setUserName(name.text);
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                              name: name.text,
                            );
                          }
                        }),
                    const SizedBox(height: 20),
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
