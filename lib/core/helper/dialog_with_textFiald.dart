import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/Custom_TextField.dart';

import '../../generated/l10n.dart';
import '../text_styles/Styles.dart';
import '../widgets/custom_botton.dart';

void showTextFieldDialog(
    BuildContext context,
    TextEditingController controller,
    void Function() onPressed,
    GlobalKey<FormState> key,
    String title,
    String label,
    String hint,
    bool obscureText) {
  showDialog(
      context: context,
      builder: (_) {
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
                    const Spacer(),
                    Text(title, style: Styles.textStyle14),
                    const Spacer(),
                  ],
                ),
                // const SizedBox(height: 20),
                // Text(
                //   label,
                //   style: Styles.textStyle14,
                // ),
                const SizedBox(height: 20),
                CustomTextField(
                  obscureText: obscureText,
                  textEditingController: controller,
                  hinttext: hint,
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomBotton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        onPressed();
                      }
                    },
                     width: 100,
                    backgroundColor: kPrimaryColor,
                    textColor: Colors.white,
                    text: S.of(context).add,
                  ),
                )
              ],
            ),
          ),
        );
      });
}
