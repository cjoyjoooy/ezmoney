import '/successpage.dart';
import 'package:flutter/material.dart';

class ConfirmTransactionPage extends StatefulWidget {
  const ConfirmTransactionPage({super.key, required this.transactionType});
  final String transactionType;

  @override
  State<ConfirmTransactionPage> createState() => _ConfirmTransactionPageState();
}

class _ConfirmTransactionPageState extends State<ConfirmTransactionPage> {
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
                          'Feiah Macalde',
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
                          '\$250',
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
                          '\$2',
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
                          '\$252',
                          textAlign: TextAlign.right,
                          style:
                              fontDefault(secondaryColor(1), FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: btnStyle(accentColor(1), primaryColor(1)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Success(),
                    ),
                  );
                },
                child: Text(
                  _getTransactionButton(widget.transactionType),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
