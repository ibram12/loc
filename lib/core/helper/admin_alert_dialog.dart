import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void adminAlrtDialog(
    {required BuildContext context, required Function() onAccept, required Function() onReject}) {
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('ramy needs to book hall 1 from 10:00 to 12:00'),
          actions: [
            TextButton(
              onPressed: onAccept,
              child: const Text('Accept',style: TextStyle(color: Colors.green),),
            ),
            TextButton(
              onPressed: onReject,
              child: const Text('Rejection the request',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
}
