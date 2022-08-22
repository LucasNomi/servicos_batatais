import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;

  const TextFieldInput({
    Key? key,
    required this.controller,
    required this.icon,
    required this.labelText,
    required this.hintText,
    required this.inputType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder();
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: inputBorder,
        icon: icon,
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: inputType,
      obscureText: obscureText,
    );
  }
}
