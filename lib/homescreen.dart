import 'package:cloud_firestore/cloud_firestore.dart';

import '/banktransferpage.dart';
import '/billspage.dart';
import '/buyloadpage.dart';
import '/cashinpage.dart';
import '/sendmoneypage.dart';
import 'models/appstyle.dart';
import 'transaction.dart' as CustomTransaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<num> fetchUserBalance(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final balance = userData['Balance'] as num; // Cast as num
        print('Balance Retrieved: $balance');
        return balance;
      } else {
        print('User document does not exist.');
        return 0; // Return a default value if the user document doesn't exist
      }
    } catch (e) {
      print('Error fetching user balance: $e');
      return 0; // Handle error gracefully
    }
  }

  Future<String> fetchUsername(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final username = userData['Username'] as String;
        return username;
      } else {
        return 'Unknown'; // Return a default value if the document doesn't exist
      }
    } catch (e) {
      print('Error fetching username: $e');
      return 'Unknown'; // Handle error gracefully
    }
  }

  Widget totalBalance() {
    return FutureBuilder<num>(
      // Change FutureBuilder to use num
      future: fetchUserBalance(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final balance = snapshot.data ??
              0.0; // Use the retrieved balance or a default value
          final formattedBalance = balance.toStringAsFixed(
              2); // Format the balance as a string with 2 decimal places
          return Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: tertiaryColor(1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Balance",
                        style: fontDefault(secondaryColor(.4), FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            '\u20B1 $formattedBalance',
                            style: TextStyle(
                                fontSize: 30,
                                color: secondaryColor(1),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor(1),
                          foregroundColor: secondaryColor(1),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CashIn(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Cash In'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget servicesIcon(iconVal, serviceLabel) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: tertiaryColor(1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              iconVal,
              size: 38,
              color: accentColor(1),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            serviceLabel,
            style: fontSecondary(secondaryColor(1), FontWeight.w800),
          ),
        ],
      );

  appServices() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SendMoneyPage(),
                ),
              );
            },
            child: servicesIcon(Icons.swap_horiz_outlined, "Send"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BankTransferPage(),
                ),
              );
            },
            child: servicesIcon(Icons.account_balance_outlined, "Transfer"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Bills(),
                ),
              );
            },
            child: servicesIcon(Icons.receipt_long_outlined, "Bills"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BuyLoadPage(),
                ),
              );
            },
            child: servicesIcon(Icons.phone_android_outlined, "Load"),
          ),
        ],
      );

  Widget transaction(type, date, amount) => Column(
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
                    date,
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                ],
              ),
              Text(
                '- $amount',
                style: fontTertiary(secondaryColor(1), FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: primaryColor(1),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Hello,',
                  style: fontSecondary(secondaryColor(.6), FontWeight.w500),
                ),
                FutureBuilder<String>(
                  future: fetchUsername(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                          'Loading...'); // Show loading indicator while fetching data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final username = snapshot.data ?? 'Unknown';
                      return Text(
                        username,
                        style: fontDefault(secondaryColor(1), FontWeight.bold),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor(1),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            totalBalance(),
            const SizedBox(
              height: 20,
            ),
            appServices(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: tertiaryColor(1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Transactions",
                          style:
                              fontTertiary(secondaryColor(1), FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CustomTransaction
                                    .Transaction(), // Use the Transaction widget
                              ),
                            );
                          },
                          child: Text(
                            "See all",
                            style:
                                fontTertiary(accentColor(1), FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    transaction('Send money', '03 Aug 2023', 1500),
                    transaction('Send money', '03 Aug 2023', 1500),
                    transaction('Send money', '03 Aug 2023', 1500),
                    transaction('Send money', '03 Aug 2023', 1500),
                    transaction('Send money', '03 Aug 2023', 1500),
                    transaction('Send money', '03 Aug 2023', 1500),
                    transaction('Send money', '03 Aug 2023', 1500),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
