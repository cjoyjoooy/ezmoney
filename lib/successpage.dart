import '/homepage.dart';
import 'package:flutter/material.dart';

import 'models/appstyle.dart';

class Success extends StatefulWidget {
  const Success({
    super.key,
  });

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
        margin: const EdgeInsets.only(bottom: 100),
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
