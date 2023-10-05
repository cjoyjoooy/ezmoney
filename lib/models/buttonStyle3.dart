import 'package:flutter/material.dart';

import 'appstyle.dart';

class Button3 extends StatelessWidget {
  const Button3(
      {super.key,
      required this.btnLabel,
      required this.iconVal,
      required this.onPressedMethod});

  final String btnLabel;
  final IconData iconVal;
  final VoidCallback onPressedMethod;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
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
        icon: Icon(
          iconVal,
          color: primaryColor(1),
        ),
        label: Text(btnLabel));
  }
}
