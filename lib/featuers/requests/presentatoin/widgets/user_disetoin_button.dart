import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';

class UserDisetoinButton extends StatelessWidget {
  const UserDisetoinButton(
      {super.key, required this.bottonName, required this.color, required this.onPressed});
  final String bottonName;
  final Color color;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: color),
        ),
        child:
            Text(bottonName, style: Styles.textStyle16.copyWith(color: color)),
      ),
    );
  }
}
