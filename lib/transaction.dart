import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/appstyle.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  Widget transaction(type, Timestamp date, amount) {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date.toDate());
    String amountText = amount.toString(); // Convert amount to string initially

    // Check if transactionType is 'Cash In' and modify amountText accordingly
    if (type == 'Cash in') {
      amountText = '+ $amountText';
    } else {
      amountText = '- $amountText';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                  ),
                  Text(
                    formattedDate, // Use the formatted date here
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                ],
              ),
              Text(
                amountText,
                style: fontTertiary(secondaryColor(1), FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Transaction')
            .orderBy('Date',
                descending: true) // Order by 'Date' field in descending order
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while fetching data.
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final transactions = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transactionData =
                  transactions[index].data() as Map<String, dynamic>;
              final transactionType = transactionData['Transaction Type'];
              final date = transactionData['Date'];
              final amount = transactionData['Amount'];

              return transaction(transactionType, date, amount);
            },
          );
        },
      ),
    );
  }
}
