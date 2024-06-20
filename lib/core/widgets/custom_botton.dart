import 'package:flutter/material.dart';

import '../text_styles/Styles.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton(
      {super.key,
      this.borderRadius,
      this.backgroundColor,
      this.textColor,
      required this.text,
      this.onPressed,
      this.width, this.child});

  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;
  final String text;
  final void Function()? onPressed;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width / 1.7,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(16)),
            backgroundColor: backgroundColor ?? Colors.white),
        onPressed: onPressed,
        child: child?? Text(
          text,
            style: Styles.textStyle18.copyWith(
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.w900,
            ),
        ),
      ),
    );
  }
}
