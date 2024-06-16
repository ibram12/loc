  import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

void showItemAlertDialog({required BuildContext context ,required void Function() onPressed, required String title, required String content,bool showDeletetionText = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title) ,
          content: Text(showDeletetionText? '${S.of(context).are_You_Sure_To_Remove_This} $content?':content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancal),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(showDeletetionText? S.of(context).remove:S.of(context).log_out,style: const TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }