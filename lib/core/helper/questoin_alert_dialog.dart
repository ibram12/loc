  import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/l10n.dart';

void questionItemAlert({required BuildContext context ,required void Function() onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Lottie.asset('assets/animations/Animation - 1716203865264.json'),
          content: const Text('Do you Need To Edit Your Request ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancal),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text('Edit',style: TextStyle(color: Colors.blueAccent),),
            ),
          ],
        );
      },
    );
  }