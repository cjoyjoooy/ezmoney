import 'package:flutter/material.dart';

import 'appstyle.dart';

class BirthDateField extends StatelessWidget {
  const BirthDateField({
    super.key,
    required this.txtController,
    required this.onTapMethod,
  });

  final TextEditingController txtController;
  final VoidCallback onTapMethod;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      style: fontDefault(secondaryColor(1), FontWeight.w500),
      controller: txtController,
      onTap: () {
        onTapMethod();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your birthdate';
        }
        return null;
      },
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
        labelText: "Birthdate",
        suffixIcon: const Icon(Icons.calendar_today_outlined),
      ),
    );
  }
}
