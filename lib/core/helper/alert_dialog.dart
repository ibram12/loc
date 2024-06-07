import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';



  void showAlertDialog({
    required BuildContext context,
    required String message,
    required Function() onOkPressed,
  }) {
    
        showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(message),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  onOkPressed();
                },
                child:  Text(
                  S.of(context).Ok,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );

    
  }