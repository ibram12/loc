import 'package:flutter/material.dart';

// ignore: camel_case_types
class cardTextField extends StatelessWidget {
  cardTextField({
    super.key,
    required this.value,
    required this.hinttext,
    required this.textEditingController,
  }
  );
  Function(String) value;
  final String hinttext;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      textAlign: TextAlign.center,
      onChanged: value,
      decoration: InputDecoration(
        hintText: hinttext,
        contentPadding: const EdgeInsets.symmetric( vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(

            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
