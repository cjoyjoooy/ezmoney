import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/models/textfield.dart';
import 'package:ezmoney/models/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/confirmtransactionpage.dart';
import 'package:flutter/material.dart';

import 'UserTransaction.dart';
import 'models/appstyle.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({
    super.key,
  });

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future createSend() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final newSend = UserTransaction(
        email: user.email ?? 'Unknown',
        transactiontype: 'Send Money',
        bank: '',
        accountnumber: '',
        amount: double.tryParse(amountController.text) ?? 0.0,
        network: '',
        accountname: nameController.text,
        date: DateTime.now(),
        id: user.uid, // Set the UID here
      );

      final json = newSend.toJson();

      try {
        await FirebaseFirestore.instance
            .collection('Transaction')
            .doc()
            .set(json);
      } catch (e) {
        print('Error creating Send Money transaction: $e');
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
            Form(
              key: _formKey,
              child: Container(
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
                    NormalTextField(
                      txtController: nameController,
                      label: "Recipient's Name",
                      validator: validateField,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: amountController,
                      label: "Amount",
                      validator: validateField,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: messageController,
                      label: "Message (optional)",
                      validator: validateField,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
            child: Button(
              btnLabel: "Next",
              onPressedMethod: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmTransactionPage(
                        transactionType: "Send",
                        createTransferCallback: createSend,
                        updateBalanceCallback: updateBalance,
                        name: nameController.text,
                        amount: amountController.text,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
