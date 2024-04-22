  import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

void showDeleteItemAlert({required BuildContext context ,required String index,void Function()? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).title_alart),
          content: Text(S.of(context).mass_alart),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert dialog
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