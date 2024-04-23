import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/auth/presentation/views/sginup_view.dart';

import '../../../../core/helper/snack_bar.dart';
import '../../../../core/text_styles/Styles.dart';
import '../../../../core/widgets/Custom_TextField.dart';
import '../../../../core/widgets/custom_botton.dart';

class PasswordRecavoryBody extends StatefulWidget {
  const PasswordRecavoryBody({super.key});

  @override
  State<PasswordRecavoryBody> createState() => _PasswordRecavoryBodyState();
}

class _PasswordRecavoryBodyState extends State<PasswordRecavoryBody> {
  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  String email = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: const Text(
            "Password Recovery",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          "Enter your email",
          style: Styles.textStyle20.copyWith(color: Colors.white),
        ),
        Expanded(
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      CustomTextField(
                          textEditingController: emailController,
                          hinttext: "Email",
                          onSaved: (value) {
                            email = value!;
                          }
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomBotton(
                        backgroundColor: kOrange,
                        text: 'Send Email',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                            });
                            resetPassword();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignUpView.id);
                            },
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                  color: Color.fromARGB(225, 184, 166, 6),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))),
      ],
    );
  }

  resetPassword() async {
    try {
      if (email.isEmpty) {
        showSnackBar(context, 'Please enter your email.');
        return;
      }

      print('Sending password reset email to: $email');
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      showSnackBar(context, 'Password Reset Email has been sent !');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else {
        print('Error sending password reset email: $e');
        showSnackBar(context, 'An error occurred. Please try again later.');
      }
    }
  }
}
