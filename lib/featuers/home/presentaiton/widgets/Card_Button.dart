import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/widgets/custom_botton.dart';

import '../../../../core/text_styles/Styles.dart';

class Card_Button extends StatelessWidget {
  const Card_Button({
    super.key,
    required this.page,
    required this.text,
    required this.icon, this.color,
  });
  final Widget page;
  final String text;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CustomBotton(
      text: text,
      backgroundColor: color??kOrange,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext context, setState) => page,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: Styles.textStyle18.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
