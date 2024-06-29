import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/delightful_toast.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/widgets/password_text_field.dart';
import 'package:loc/featuers/admin/pressntation/widgets/select_services_and_roles_section.dart';
import 'package:loc/featuers/admin/pressntation/widgets/sgin_up_buttom.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/Custom_TextField.dart';
import '../../../../generated/l10n.dart';
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
                message: S.of(context).admin_feature_wrong_password,
                context: context,
                dismiss: true);
          });
        } else if (state is SignUpLoading) {
          Navigator.pop(context);
        }
        if (state is AdminBackToHisAccount) {
          email.clear();
          password.clear();
          name.clear();
          signUpController.clear();
          role = 'Role';

          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, S.of(context).sign_up_successfully);
          });
        } else if (state is SignUpError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, state.message);
          });
        }
        return PopScope(
          canPop: state is AdminBackToHisAccount || state is SignUpInitial,
          child: ModalProgressHUD(
            inAsyncCall: state is SignUpLoading,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const CustomLogoAuth(),
                      const SizedBox(height: 20),
                      Text(S.of(context).sign_up, style: Styles.textStyle30),
                      const SizedBox(height: 10),
                      Text(S.of(context).add_new_user,
                          style: Styles.textStyle14),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).name,
                        style: Styles.textStyle18,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hinttext: S.of(context).user_name,
                          textEditingController: name),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).email,
                        style: Styles.textStyle18,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hinttext: S.of(context).enter_user_email,
                          textEditingController: email),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).password,
                        style: Styles.textStyle18,
                      ),
                      const SizedBox(height: 10),
                      PasswordTextField(
                          onSaved: (value) {},
                          hinttext: S.of(context).password,
                          textEditingController: password),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SelectRoleAndServiceSection(
                              items: kServices,
                              hint: S.of(context).select_services,
                              onServiceSelected: (selectedServices) {
                                setState(() {
                                  services = selectedServices;
                                });
                              },
                              onRoleSelected: (String selectedRole) {
                                setState(() {
                                  role = selectedRole;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SginUpButtom(
                          services: services,
                          role: role,
                          formKey: formKey,
                          signUpController: signUpController,
                          signUpKey: signUpKey,
                          email: email,
                          password: password,
                          name: name),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
