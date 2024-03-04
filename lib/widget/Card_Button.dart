import 'package:flutter/material.dart';

class Card_Button extends StatelessWidget {
  const Card_Button({
    super.key,
    required this.page,
    required this.text,
  });
  final Widget page;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext context, setState) => page,
            ),
          ),
        );
      },
      child: Text(text),
    );
  }
}
