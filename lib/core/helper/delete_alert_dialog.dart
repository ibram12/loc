  import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

void showDeleteItemAlert({required BuildContext context ,required void Function() onPressed, required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title) ,
          content: Text('${S.of(context).Are_You_Sure_To_Remove_This} $content?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancal),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(S.of(context).remove,style: const TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }