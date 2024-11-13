import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChange;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CommonTextField({
    required this.controller,
    required this.hintText,
    required this.onChange,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      onChanged: onChange,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
