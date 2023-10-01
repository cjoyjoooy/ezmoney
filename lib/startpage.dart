import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/models/buttonStyle2.dart';

import '/authenticator.dart';
import '/signuppage.dart';
import 'package:flutter/material.dart';

import 'models/appstyle.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

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
            Button(
              btnLabel: "Sign In",
              onPressedMethod: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Authenticator(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Button2(
              btnLabel: "Sign Up",
              onPressedMethod: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
