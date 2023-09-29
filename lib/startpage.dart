import '/authenticator.dart';
import '/signuppage.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

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
        fontSize: 20,
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
  btnStyle2(backColor, foreColor) => ElevatedButton.styleFrom(
      textStyle: fontTertiary(primaryColor(1), FontWeight.bold),
      minimumSize: const Size.fromHeight(50),
      backgroundColor: backColor,
      foregroundColor: foreColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      side: BorderSide(width: 2, color: accentColor(1)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/mobileBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset(
              'images/grapy-wallet-with-cash-and-bank-card.png',
              width: 300,
            ),
            Row(
              children: [
                Container(
                  width: 280,
                  child: Text(
                    "Manage your money anytime and anywhere",
                    style: TextStyle(
                        fontSize: 32,
                        color: secondaryColor(1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: btnStyle(accentColor(1), primaryColor(1)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Authenticator(),
                  ),
                );
              },
              child: const Text(
                "Sign In",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: btnStyle2(
                primaryColor(1),
                accentColor(1),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
              child: const Text(
                "Sign Up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
