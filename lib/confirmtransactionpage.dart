import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/successpage.dart';
import 'package:flutter/material.dart';

import 'models/appstyle.dart';

class ConfirmTransactionPage extends StatefulWidget {
  const ConfirmTransactionPage({
    Key? key,
    required this.transactionType,
    required this.createTransferCallback,
    required this.updateBalanceCallback,
    required this.name,
    required this.amount,
  }) : super(key: key);

  final String transactionType;
  final Function createTransferCallback;
  final Function updateBalanceCallback;
  final String name;
  final String amount;

  @override
  State<ConfirmTransactionPage> createState() => _ConfirmTransactionPageState();
}

class _ConfirmTransactionPageState extends State<ConfirmTransactionPage> {
  String _getTransactionButton(String transactionType) {
    final labelMap = {
      "Send": "Send Money",
      "Bank Transfer": "Transfer Money",
      "Load": "Confirm",
      "Cash In": "Confirm",
    };

    return labelMap[transactionType] ?? "Confirm";
  }

  String _getTransactionLabel(String transactionType) {
    final labelMap = {
      "Send": "Send to",
      "Bank Transfer": "Transfer to",
      "Load": "Buy Load to",
      "Cash In": "Cash In",
    };

    return labelMap[transactionType] ?? "Recipient";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(1),
      appBar: AppBar(
        centerTitle: true,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: 400,
                height: 280,
                decoration: BoxDecoration(
                  color: tertiaryColor(1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Confirm Transaction',
                      style: fontTertiary(secondaryColor(1), FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getTransactionLabel(widget.transactionType),
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                        Text(
                          widget.name,
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount',
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                        Text(
                          widget.amount,
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction Fee',
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                        Text(
                          '\$0',
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total amount',
                          textAlign: TextAlign.left,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                        Text(
                          widget.amount,
                          textAlign: TextAlign.right,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Button(
                btnLabel: _getTransactionButton(widget.transactionType),
                onPressedMethod: () async {
                  // Calculate newBalance based on your application logic
                  final enteredAmount = double.tryParse(widget.amount) ?? 0.0;

                  // Fetch the current balance from your data source (e.g., Firebase Firestore)
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final userData = await FirebaseFirestore.instance
                        .collection('User')
                        .doc(user.uid)
                        .get();
                    final currentBalance = userData['Balance'] ?? 0.0;

                    double newBalance;

                    // Check the transactionType and calculate newBalance accordingly
                    if (widget.transactionType == 'Cash In') {
                      newBalance = currentBalance + enteredAmount;
                    } else {
                      newBalance = currentBalance - enteredAmount;
                    }

                    // Call updateBalanceCallback with the calculated newBalance
                    widget.updateBalanceCallback(newBalance);
                    // Invoke the createTransferCallback function
                    widget.createTransferCallback();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Success(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
