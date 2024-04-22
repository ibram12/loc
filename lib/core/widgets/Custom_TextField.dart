import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onSaved,
    required this.hinttext,
    required this.textEditingController,
  });
  final void Function(String?) onSaved;
  final String hinttext;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'value is required';
        }
        return null;
      },
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
