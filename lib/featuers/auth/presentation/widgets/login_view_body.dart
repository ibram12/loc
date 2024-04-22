import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/widgets/Custom_TextField.dart';
import '../widgets/custom_logo_auth.dart';

class LogInViewBody extends StatefulWidget {
  const LogInViewBody({super.key});

  @override
  State<LogInViewBody> createState() => _LogInViewBodyState();
}

class _LogInViewBodyState extends State<LogInViewBody> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const Text("Login", style: Styles.textStyle30),
              const  SizedBox(height: 10),
                const Text("Login To Continue Using The App",
                    style: Styles.textStyle14),
              const  SizedBox(height: 20),
                const Text(
                  "Email",
                  style: Styles.textStyle18,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    onSaved: (value) {},
                    hinttext: "ُEnter Your Email",
                    textEditingController: email),
                const SizedBox(height: 10),
                const Text(
                  "Password",
                  style: Styles.textStyle18,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    onSaved: (value) {},
                    hinttext: "ُEnter Your Password",
                    textEditingController: password),
                InkWell(
                  // onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text("Forgot Password ?",
                        style: Styles.textStyle14),
                  ),
                ),
                CustomBotton(
                    width: double.infinity,
                    backgroundColor: Colors.orange,
                    text: "login",
                    onPressed: (){}),
              const  SizedBox(height: 20),
                MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red[700],
                    textColor: Colors.white,
                    onPressed: (){
                    
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login With Google  "),
                        Image.asset(
                          "assets/images/4.png",
                          width: 20,
                        )
                      ],
                    )),
                Container(height: 20),
                // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,),
                InkWell(
                  onTap: () {
                  //  Navigator.of(context).pushNamed("signup");
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                      TextSpan(
                        text: "Don't Have An Account ? ",
                      ),
                      TextSpan(
                          text: "Register",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                    ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
