import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/helper/delightful_toast.dart';
import 'package:loc/core/helper/dialog_with_textFiald.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/widgets/password_text_field.dart';
import 'package:loc/featuers/admin/pressntation/widgets/multi_drop_down_button_to_services.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import '../../../../core/utils/constants.dart';
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
  TextEditingController signUpController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey();

  GlobalKey<FormState> formKey = GlobalKey();
  List<String> services = [];
  String role = 'Role';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    name.dispose();
    signUpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        if (state is AdminEnterWrongPassword) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDelightfulToast(
                message: 'Wrong Password', context: context, dismiss: true);
          });
        } else if (state is AdminEnterTruePassword || state is SignUpError) {
          Navigator.pop(context); //close the dialog
        }
        if (state is AdminBackToHisAccount) {
          email.clear();
          password.clear();
          name.clear();
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
                        hinttext: "User Name", textEditingController: name),
                    const SizedBox(height: 10),
                    const Text(
                      "Email",
                      style: Styles.textStyle18,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hinttext: "ُEnter User Email",
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
                        Expanded(
                          child: MultiSelectDropdown(
                            items: kServices,
                            hint: 'Select Services',
                            onServiceSelected: (selectedServices) {
                              services = selectedServices;
                            },
                            onRoleSelected: (String selectedRole) {
                              role = selectedRole;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  
                    CustomBotton(
                        width: double.infinity,
                        backgroundColor: Colors.orange,
                        text: "Sign Up",
                        onPressed: () {
                          if (services.isEmpty) {
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
                              services.isNotEmpty) {
                            showTextFieldDialog(context, signUpController,
                                () async {
                              if (signUpKey.currentState!.validate()) {
                                await BlocProvider.of<SignUpCubit>(context)
                                    .createUserWithEmailAndPassword(
                                  services: services,
                                  role: role,
                                  email: email.text,
                                  userpassword: password.text,
                                  adminPassword: signUpController.text,
                                  name: name.text,
                                );
                              }
                            }, signUpKey, 'Enter Admin Password',
                                'Admin Password', 'Admin Password',true);
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
