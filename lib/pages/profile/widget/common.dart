import 'package:flutter/material.dart';

Widget buildRadioField({
  required String? groupValue,
  required void Function(String?) onChanged,
  required String value,
}) {
  return Expanded(
    child: ListTile(
      title: Text(value),
      leading: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: (value) => onChanged(value),
      ),
    ),
  );
}

Widget buildTextField({
  required String name,
  required String? initialValue,
  required String labelText,
  required void Function(String?) onChanged,
  required String? Function(String?) validator,
}) {
  const icons = {
    'email': Icons.email,
    'phone': Icons.phone,
    'name': Icons.person,
  };
  return TextFormField(
    initialValue: initialValue,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icons[name]),
    ),
    onChanged: onChanged,
    validator: validator,
  );
}

Widget buildPasswordField({
  required String name,
  required String? initialValue,
  required bool obscureText,
  required String labelText,
  required void Function(String?) onChanged,
  required void Function() togglePasswordVisibility,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    initialValue: initialValue,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: 'Password',
      prefixIcon: const Icon(Icons.lock),
      suffix: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: togglePasswordVisibility,
      ),
    ),
    onChanged: onChanged,
    validator: validator,
  );
}
