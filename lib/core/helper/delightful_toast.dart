import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';

void showDelightfulToast(String message, BuildContext context) {
  DelightToastBar(builder: (context) {
    return ToastCard(
      leading: const Icon(Icons.error,color: Colors.red,),
      title: Text(message,style: Styles.textStyle14,),
    );
  },
  autoDismiss: true,
  snackbarDuration:Durations.extralong4
  ).show(context);
}
