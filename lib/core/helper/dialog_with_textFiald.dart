import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/Custom_TextField.dart';

import '../text_styles/Styles.dart';
import '../widgets/custom_botton.dart';

void showTextFieldDialog(BuildContext context,TextEditingController controller,void Function() onPressed,GlobalKey<FormState> key ) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel)),
                    //  SizedBox(width: 30,),
                    const Spacer(),
                    Text("Enter Password",
                        style: Styles.textStyle14.copyWith(color: Colors.black)),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Password',
                  
                  style: Styles.textStyle14,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  textEditingController: controller,
                  hinttext: 'Enter your password ',),
                const SizedBox(height: 20),
                Center(
                  child: CustomBotton(
                    onPressed: onPressed,
                    width:100,
                    backgroundColor: kPrimaryColor,
                    textColor: Colors.white,
                    text: 'Add',
                  ),
                )
              ],
            ),
          ),
        );
      });
}