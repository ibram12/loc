import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:loc/core/widgets/custom_botton.dart';

import '../../../../core/widgets/Custom_TextField.dart';
import '../views/login_view.dart';
import '../widgets/custom_logo_auth.dart';

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
                const Text("Sign Up", style: Styles.textStyle30),
              const  SizedBox(height: 10),
                const Text("Create Your Account",
                    style: Styles.textStyle14),
              const  SizedBox(height: 10),
              const Text(
                  "Name",
                  style: Styles.textStyle18,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    onSaved: (value) {},
                    hinttext: "ُYour Name",
                    textEditingController: name),
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                CustomBotton(
                    width: double.infinity,
                    backgroundColor: Colors.orange,
                    text: "Sign Up",
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
                        const Text("Sign Up With Google  "),
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
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                      TextSpan(
                        text: "Already Have An Account ? ",
                      ),
                      TextSpan(
                          text: "Login",
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
