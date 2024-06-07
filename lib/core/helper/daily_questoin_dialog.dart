import 'package:flutter/material.dart';
import 'package:loc/generated/l10n.dart';

void showDailyQuestion({required BuildContext context,required Function() onChoiseNotDaily,required Function() onChoiseDaily}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:  Text(S.of(context).is_This_reservatoin_Daily),
          actions: [
            TextButton(
                onPressed: onChoiseNotDaily,
                child:  Text(
                  S.of(context).not_daily,
                  style: const TextStyle(color: Colors.red),
                )),
            TextButton(
                onPressed: onChoiseDaily,
                child:  Text(
                  S.of(context).daily,
                  style: const TextStyle(color: Colors.green),
                )),
          ],
        );
      });
}
