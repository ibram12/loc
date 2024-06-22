import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/widgets/password_text_field.dart';
import 'package:loc/featuers/auth/presentation/manager/cubits/logIn_cubit/log_in_cubit.dart';
import 'package:loc/featuers/auth/presentation/views/password_recovary_view.dart';
import 'package:loc/featuers/home/presentaiton/views/homePage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import '../../../../core/widgets/Custom_TextField.dart';
import '../../../../generated/l10n.dart';
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
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        if (state is LogInLoading) {
          isLoading = true;
        } else if (state is LogInError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showSnackBar(context, state.message);
          });
        } else if (state is LogInSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacementNamed(context, MyHomePage.id);
            showSnackBar(context, S.of(context).wellcome);
          });
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const CustomLogoAuth(),
                    const SizedBox(height: 20),
                     Text(S.of(context).login, style: Styles.textStyle30),
                    const SizedBox(height: 10),
                     Text(S.of(context).login_to_continue_using_the_app,
                        style: Styles.textStyle14),
                    const SizedBox(height: 20),
                     Text(
                      S.of(context).email,
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        onSaved: (value) {
                          email.text = value!;
                        },
                        hinttext: S.of(context).enter_user_email,
                        textEditingController: email),
                    const SizedBox(height: 10),
                     Text(
                      S.of(context).login_password,
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    PasswordTextField(
                        onSaved: (value) {
                          password.text = value!;
                        },
                        hinttext: S.of(context).password,
                        textEditingController: password),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PasswordRecoveryVeiw.id);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.topRight,
                        child:  Text(S.of(context).forgot_password,
                            style: Styles.textStyle14),
                      ),
                    ),
                    CustomBotton(
                        width: double.infinity,
                        backgroundColor: Colors.orange,
                        text: S.of(context).login,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BlocProvider.of<LogInCubit>(context)
                                .logInWithEmailAndPassword(context,
                                    email.text, password.text);
                          }
                        }),
                    const SizedBox(height: 20),

                    // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,),
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
