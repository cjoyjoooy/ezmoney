import 'package:flutter/material.dart';

import 'appstyle.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,

      required this.btnLabel,
      required this.onPressedMethod});


  final String btnLabel;
  final VoidCallback onPressedMethod;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: fontTertiary(primaryColor(1), FontWeight.bold),
        minimumSize: const Size.fromHeight(50),
        backgroundColor: accentColor(1),
        foregroundColor: primaryColor(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        onPressedMethod();
      },
      child: Text(btnLabel),
    );
  }
}
