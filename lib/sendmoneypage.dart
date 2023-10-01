import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/confirmtransactionpage.dart';
import 'package:flutter/material.dart';

import 'UserTransaction.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({
    super.key,
  });

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
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

  txtFieldStyle(label) => InputDecoration(
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(250, 250, 250, .4),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(155, 128, 231, 1),
          ),
        ),
        labelStyle: fontDefault(secondaryColor(.5), FontWeight.w400),
        labelText: label,
      );

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future createSend() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final newCashin = UserTransaction(
        email: user.email ?? 'Unknown',
        transactiontype: 'Send Money',
        bank: '',
        accountnumber: '',
        amount: double.tryParse(amountController.text) ?? 0.0,
        network: '',
        accountname: '',
        date: DateTime.now(),
      );

      final json = newCashin.toJson();

      try {
        await FirebaseFirestore.instance
            .collection('Transaction')
            .doc() // Firestore will auto-generate a unique document ID
            .set(json);
      } catch (e) {
        print('Error creating Cash In transaction: $e');
        // Handle error gracefully
      }
    }
  }

  Future<void> updateBalance(double newBalance) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(user.uid)
            .update({'Balance': newBalance});
      } catch (e) {
        print('Error updating balance: $e');
        // Handle error gracefully
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
            space: 0.0,
            color: Colors.transparent // Set the divider height to 0.0
            ),
      ),
      child: Scaffold(
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
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Send Money",
                        style: fontHeader(secondaryColor(1), FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                    decoration: txtFieldStyle("Recipient's Name"),
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                    decoration: txtFieldStyle("Amount"),
                    controller: amountController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                    decoration: txtFieldStyle("Message (optional)"),
                    controller: messageController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: ElevatedButton(
              style: btnStyle(accentColor(1), primaryColor(1)),
              onPressed: () {
                // Parse the amount entered in the TextField
                final enteredAmount =
                    double.tryParse(amountController.text) ?? 0.0;

                // Retrieve the current balance from Firebase
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  FirebaseFirestore.instance
                      .collection('User')
                      .doc(user.uid)
                      .get()
                      .then((userDoc) {
                    if (userDoc.exists) {
                      final userData = userDoc.data() as Map<String, dynamic>;
                      final currentBalance = userData['Balance'] as double;

                      // Calculate the new balance
                      final newBalance = currentBalance - enteredAmount;

                      // Update the balance in Firebase
                      createSend();
                      updateBalance(newBalance);

                      // Navigate to the confirmation page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConfirmTransactionPage(
                            transactionType: 'Cash In',
                          ),
                        ),
                      );
                    }
                  }).catchError((error) {
                    print('Error fetching user data: $error');
                    // Handle error gracefully
                  });
                }
              },
              child: const Text(
                "Next",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
