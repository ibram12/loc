import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';

void showDelightfulToast({required String message, required BuildContext context,required bool dismiss}) {
  DelightToastBar(builder: (context) {
    return ToastCard(
      color: Colors.red,
      leading: const Icon(Icons.error,color: Colors.white,),
      title: Text(message,style: Styles.textStyle14.copyWith(color: Colors.white),),
    );
  },
  
  autoDismiss: dismiss,
  snackbarDuration:Durations.extralong4
  ).show(context);
}
