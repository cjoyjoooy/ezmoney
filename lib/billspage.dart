import 'package:flutter/material.dart';

import 'models/appstyle.dart';

class Bills extends StatelessWidget {
  const Bills({super.key});

  @override
  Widget build(BuildContext context) {
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
