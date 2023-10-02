import 'package:flutter/material.dart';

import 'models/appstyle.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  Widget transaction(type, date, name, amount) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                ),
                Text(
                  date,
                  style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                ),
                Text(
                  '-\$$amount',
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(1),
      appBar: AppBar(
        title: Text(
          'Transaction',
          style: fontTertiary(secondaryColor(1), FontWeight.bold),
        ),
        centerTitle: true,
        surfaceTintColor: primaryColor(1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: accentColor(1),
        ),
        backgroundColor: primaryColor(1),
        elevation: 0,
      ),
      body: ListView(
        children: [
          transaction('Send money to', '03 Aug 2023', 'Feiah Macalde', 3600),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction(
              'Send money to', '15 Sep 2023', 'Celeste Joy Vagilidad', 1500),
          transaction('Send money to', '03 Aug 2023', 'Feiah Macalde', 3600),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction(
              'Send money to', '15 Sep 2023', 'Celeste Joy Vagilidad', 1500),
          transaction('Send money to', '03 Aug 2023', 'Feiah Macalde', 3600),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction(
              'Send money to', '15 Sep 2023', 'Celeste Joy Vagilidad', 1500),
          transaction('Send money to', '03 Aug 2023', 'Feiah Macalde', 3600),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction('Send money to', '03 Aug 2023', 'Lex Vincent Lao', 500),
          transaction(
              'Send money to', '15 Sep 2023', 'Celeste Joy Vagilidad', 1500),
        ],
      ),
    );
  }
}
