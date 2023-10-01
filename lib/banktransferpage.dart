import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/confirmtransactionpage.dart';
import 'package:flutter/material.dart';

import 'UserTransaction.dart';

class BankTransferPage extends StatefulWidget {
  const BankTransferPage({super.key});

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
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

  comboBoxStyle(label) => InputDecoration(
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

  TextEditingController accountnameController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future createTransfer() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && _selectedBank != null) {
      final newCashin = UserTransaction(
        email: user.email ?? 'Unknown',
        transactiontype: 'Bank Transfer',
        bank: _selectedBank!,
        accountnumber: accountnumberController.text,
        amount: double.tryParse(amountController.text) ?? 0.0,
        network: '',
        accountname: accountnameController.text,
        date: DateTime.now(),
      );

      final json = newCashin.toJson();

      try {
        await FirebaseFirestore.instance
            .collection('Transaction')
            .add(json); // Firestore will auto-generate a unique document ID
      } catch (e) {
        print('Error creating Bank Transfer transaction: $e');
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

  final _bankList = [
    'Bank of the Philippine Islands',
    'BDO Unibank, Inc.',
    'Citibank Philippines',
    'East West Banking Corporation ',
    'Land Bank of the Philippines',
    'Maybank Philippines, Inc.',
    'Metropolitan Bank and Trust Company',
    'Philippine National Bank',
    'Security Bank Corporation',
    'Union Bank of the Philippines, Inc.',
  ];
  String? _selectedBank;

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
                        "Bank Transfer",
                        style: fontHeader(secondaryColor(1), FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                    value: _selectedBank,
                    items: _bankList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Container(
                          width: 310, // Adjust the width as needed
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedBank = val as String;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: secondaryColor(.5),
                    ),
                    decoration: comboBoxStyle('Bank'),
                    dropdownColor: primaryColor(1),
                  ),
                  TextField(
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                    decoration: txtFieldStyle("Account Name"),
                    controller: accountnameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    style: fontDefault(secondaryColor(1), FontWeight.w500),
                    decoration: txtFieldStyle("Account Number"),
                    controller: accountnumberController,
                  ),
                  const SizedBox(
                    height: 5,
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
                  Row(
                    children: [
                      Text(
                        'Availdable Balance:',
                        style:
                            fontSecondary(secondaryColor(0.4), FontWeight.w100),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '15,035',
                        style:
                            fontSecondary(secondaryColor(0.4), FontWeight.w100),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height:
                  16, // Adjust the space between the text fields and the button as needed
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: ElevatedButton(
              style: btnStyle(accentColor(1), primaryColor(1)),
              onPressed: () {
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
                      createTransfer();
                      updateBalance(newBalance);

                      // Navigate to ConfirmTransactionPage
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConfirmTransactionPage(
                            transactionType: "Bank Transfer",
                          ),
                        ),
                      );
                    }
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
