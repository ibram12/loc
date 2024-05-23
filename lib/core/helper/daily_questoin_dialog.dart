import 'package:flutter/material.dart';

void showDailyQuestion({required BuildContext context,required Function() onChoiseNotDaily,required Function() onChoiseDaily}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('is This reservatoin Daily ?'),
          actions: [
            TextButton(
                onPressed: onChoiseNotDaily,
                child: const Text(
                  'Not Daily',
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
                onPressed: onChoiseDaily,
                child: const Text(
                  'Daily',
                  style: TextStyle(color: Colors.green),
                )),
          ],
        );
      });
}
