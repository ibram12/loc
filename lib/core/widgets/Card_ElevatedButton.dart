// ignore: file_names
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
const  CustomElevatedButton({
    super.key,
    required this.onpressed,
    required this.text,
  });
  final void Function()?  onpressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        //backgroundColor: Colors.amber,
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontStyle: FontStyle.normal),
      ),
      child: Text(text),
    );
  }
}
