import 'package:flutter/material.dart';
import 'appstyle.dart';

class Button2 extends StatelessWidget {
  const Button2(
      {super.key, required this.btnLabel, required this.onPressedMethod});
  final String btnLabel;
  final VoidCallback onPressedMethod;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: fontTertiary(primaryColor(1), FontWeight.bold),
        minimumSize: const Size.fromHeight(50),
        backgroundColor: primaryColor(1),
        foregroundColor: accentColor(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(
          width: 2,
          color: accentColor(1),
        ),
      ),
      onPressed: onPressedMethod,
      child: Text(btnLabel),
    );
  }
}
