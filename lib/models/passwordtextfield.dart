import 'package:flutter/material.dart';

import 'appstyle.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(
      {super.key,
      required this.txtController,
      required this.label,
      required this.validator,
      required this.iconVal,
      required this.obscurevalue});

  final TextEditingController txtController;
  final String label;
  final dynamic iconVal;
  final bool obscurevalue;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscurevalue,
      style: fontDefault(secondaryColor(.9), FontWeight.w500),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(250, 250, 250, .4),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(155, 128, 231, 1),
          ),
        ),
        labelStyle: fontDefault(secondaryColor(.5), FontWeight.w400),
        labelText: label,
        suffixIcon: iconVal,
      ),
      controller: txtController,
      validator: validator,
    );
  }
}
