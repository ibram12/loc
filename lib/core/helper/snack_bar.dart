  import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String massege, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? Colors.orangeAccent,
        content: Text(massege),
        duration: const Duration(seconds: 2),
      ),
    );
  }