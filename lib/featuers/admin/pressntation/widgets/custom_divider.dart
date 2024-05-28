import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

import '../../../../core/text_styles/Styles.dart';

class CustomDiveder extends StatelessWidget {
  const CustomDiveder({super.key, required this.hallName});
  final String hallName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: <Widget>[
        const Expanded(
            child: Divider(
          thickness: 2,
          color: kPrimaryColor,
        )),
        Text(
        hallName,
          style: Styles.textStyle30,
        ),
        const Expanded(
            child: Divider(
          thickness: 2,
          color: kPrimaryColor,
        )),
      ]),
    );
  }
}
