// ignore: file_names
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onSaved,
    required this.hinttext,
    required this.textEditingController,
    this.obscureText, this.onChanged, 
  });
  final void Function(String?)? onSaved;
  final String hinttext;
  final TextEditingController textEditingController;
  final bool? obscureText;
final void Function(String?)? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      validator: (value) {
        if (value == '') {
          return 'value is required';
        }
        return null;
      },
      obscureText: obscureText ?? false,
      controller: textEditingController,
      textAlign: TextAlign.center,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hinttext,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kOrange)),
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
