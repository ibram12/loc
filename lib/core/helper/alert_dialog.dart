import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/homePage.dart';

void showAlertDialog({
  required BuildContext context,
  required String message,
  required Function() onOkPressed,
}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(message),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: onOkPressed,
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.green),
          ),
          
        ),
      ],
    ),
  );
}
