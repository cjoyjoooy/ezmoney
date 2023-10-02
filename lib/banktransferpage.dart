import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/models/combobox.dart';
import 'package:ezmoney/models/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/confirmtransactionpage.dart';
import 'package:flutter/material.dart';
import 'UserTransaction.dart';
import 'models/appstyle.dart';
import 'models/validators.dart';

class BankTransferPage extends StatefulWidget {
  const BankTransferPage({super.key});

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  final _formKey = GlobalKey<FormState>();

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
        // Update the balance in Firebase
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
    '',
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
  void initState() {
    super.initState();

    _selectedBank = _bankList[0];
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
                          "Bank Transfer",
                          style: fontHeader(secondaryColor(1), FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ComboBox(
                      label: "Bank",
                      value: _selectedBank,
                      itemList: _bankList.map((e) {
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
                      onChangeValue: (val) {
                        setState(() {
                          _selectedBank = val;
                        });
                      },
                    ),
                    NormalTextField(
                      txtController: accountnameController,
                      label: "Account Name",
                      validator: validateField,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: accountnumberController,
                      label: "Account Number",
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
                    Row(
                      children: [
                        Text(
                          'Availdable Balance:',
                          style: fontSecondary(
                              secondaryColor(0.4), FontWeight.w100),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '15,035',
                          style: fontSecondary(
                              secondaryColor(0.4), FontWeight.w100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: Button(
              btnLabel: "Next",
              onPressedMethod: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmTransactionPage(
                        transactionType: "Bank Transfer",
                        createTransferCallback: createTransfer,
                        updateBalanceCallback: updateBalance,
                        name: accountnumberController.text,
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
