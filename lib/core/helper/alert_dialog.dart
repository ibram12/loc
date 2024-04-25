import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog({required BuildContext context ,required String message}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(message),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('Ok',style: TextStyle(color: Colors.green),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}