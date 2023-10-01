import 'package:flutter/material.dart';

import 'appstyle.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField({
    super.key,
    required this.txtController,
    required this.label,
    required this.validator,
  });

  final TextEditingController txtController;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: fontDefault(secondaryColor(1), FontWeight.w500),
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
      ),
      controller: txtController,
      validator: validator,
    );
  }
}
