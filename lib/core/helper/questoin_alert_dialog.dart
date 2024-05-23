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
          content: editVisible? const Text('Do you Need To Edit Your Request ?'):const Text('Do you Need To Delete Your Request ?'),
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
                  child: const Text('Delete',style: TextStyle(color: Colors.red),),
                ),
                Visibility(
                  visible: editVisible,
                  child: TextButton(
                    onPressed: onPressed,
                    child: const Text('Edit',style: TextStyle(color: Colors.blueAccent),),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }