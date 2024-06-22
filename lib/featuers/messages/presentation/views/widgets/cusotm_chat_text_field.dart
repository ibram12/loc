import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/utils/constants.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/sent_message_cubit/sent_message_cubit.dart';
import 'not_admin_body.dart';

class CusotmChatTextField extends StatefulWidget {
  const CusotmChatTextField(
      {super.key, required this.onSent, required this.formKey,});
  final void Function() onSent;
  final GlobalKey<FormState> formKey;

  @override
  State<CusotmChatTextField> createState() => _CusotmChatTextFieldState();
}

class _CusotmChatTextFieldState extends State<CusotmChatTextField> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  bool getRoleLoading =true;
  String? userRole;

  void checkRole() async {
    userRole = await SherdPrefHelper().getUserRole();
    if(userRole!=null){
      setState(() {
  getRoleLoading = false;
});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRole();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void sendMessage() {
    if (widget.formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      BlocProvider.of<SentMessageCubit>(context)
          .sendMessage(message: controller.text)
          .then((_) {
      
        setState(() {
          isLoading = false;
        });
        controller.clear();
        widget.onSent();
      }).catchError((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return getRoleLoading ? const SizedBox() : userRole != kRoles[2] ?  const NotAdminBody() : Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return S.of(context).value_requeired;
            }
            return null;
          },
          controller: controller,
          onFieldSubmitted: (data) {
            sendMessage();
          },
          decoration: InputDecoration(
              hintText: S.of(context).your_message,
              suffixIcon: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CupertinoActivityIndicator(
                        color: kPrimaryColor,
                      ))
                  : IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                    ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: kPrimaryColor),
              )),
        ),
      ),
    );
  }
}
