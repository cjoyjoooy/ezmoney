import '/homepage.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({
    super.key,
  });

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  primaryColor(double opacityVal) => Color.fromRGBO(20, 18, 28, opacityVal);

  secondaryColor(double opacityVal) =>
      Color.fromRGBO(250, 250, 250, opacityVal);

  accentColor(double opacityVal) => Color.fromRGBO(155, 128, 231, opacityVal);

  tertiaryColor(double opacityVal) => Color.fromRGBO(34, 33, 46, opacityVal);

  fontHeader(colorVal, weightVal) => TextStyle(
        fontSize: 38,
        color: colorVal,
        fontWeight: weightVal,
        letterSpacing: 1.1,
      );

  fontDefault(colorVal, weightVal) => TextStyle(
        fontSize: 18,
        color: colorVal,
        fontWeight: weightVal,
        letterSpacing: 1.1,
      );

  fontSecondary(colorVal, weightVal) => TextStyle(
        fontSize: 16,
        color: colorVal,
        letterSpacing: 1.1,
      );

  fontTertiary(colorVal, weightVal) => TextStyle(
        fontSize: 32,
        color: colorVal,
        fontWeight: weightVal,
        letterSpacing: 1.1,
      );

  btnStyle(backColor, foreColor) => ElevatedButton.styleFrom(
        textStyle: fontTertiary(primaryColor(1), FontWeight.bold),
        minimumSize: const Size.fromHeight(50),
        backgroundColor: backColor,
        foregroundColor: foreColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(1),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: accentColor(1),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 100),
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/grapy-check-mark-in-circle.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Transaction',
                  style: fontTertiary(secondaryColor(1), FontWeight.bold),
                ),
                Text(
                  'Successful!',
                  style: fontTertiary(secondaryColor(1), FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
