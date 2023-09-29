import 'package:flutter/material.dart';

class Bills extends StatelessWidget {
  const Bills({super.key});

  @override
  Widget build(BuildContext context) {
    primaryColor(double opacityVal) => Color.fromRGBO(20, 18, 28, opacityVal);
    secondaryColor(double opacityVal) =>
        Color.fromRGBO(250, 250, 250, opacityVal);
    accentColor(double opacityVal) => Color.fromRGBO(155, 128, 231, opacityVal);

    fontHeader(colorVal, weightVal) => TextStyle(
          fontSize: 30,
          color: colorVal,
          fontWeight: weightVal,
          letterSpacing: 1.1,
        );
    return Scaffold(
      backgroundColor: primaryColor(1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: accentColor(1),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
                "This feature is under development",
                textAlign: TextAlign.center,
                style: fontHeader(secondaryColor(1), FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
