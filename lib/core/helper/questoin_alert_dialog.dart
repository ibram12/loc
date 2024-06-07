  import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../generated/l10n.dart';

void questionItemAlert({required BuildContext context ,required void Function() onPressed, required void Function() onDelete,required bool editVisible}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Lottie.asset('assets/animations/Animation - 1716203865264.json'),
          content: editVisible?  Text(S.of(context).Do_you_Need_To_Edit_Your_Request): Text(S.of(context).Do_you_Need_To_Delete_Your_Request),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).cancal),
                ),
                  TextButton(
                  onPressed: onDelete,
                  child:  Text(S.of(context).Delete,style: const TextStyle(color: Colors.red),),
                ),
                Visibility(
                  visible: editVisible,
                  child: TextButton(
                    onPressed: onPressed,
                    child:  Text(S.of(context).Edit,style: const TextStyle(color: Colors.blueAccent),),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }