import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.onSaved,
    required this.hinttext,
    required this.textEditingController,
  });
  final void Function(String?) onSaved;
  final String hinttext;
  final TextEditingController textEditingController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'value is required';
        }
        return null;
      },
     
      obscureText: obscureText,
      controller: widget.textEditingController,
      textAlign: TextAlign.center,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
              obscureText == true ? Icons.visibility_off : Icons.visibility),
        ),
        hintText: widget.hinttext,
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
