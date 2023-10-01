class UserTransaction {
  final String email;
  final String transactiontype;
  final String bank;
  final String accountnumber;
  final num amount;
  final String network;
  final String accountname;
  final DateTime date;

  UserTransaction({
    required this.email,
    required this.transactiontype,
    required this.bank,
    required this.accountnumber,
    required this.amount,
    required this.network,
    required this.accountname,
    required this.date,
  });

  static UserTransaction fromJson(Map<String, dynamic> json) => UserTransaction(
      email: json['Email'],
      transactiontype: json['Transaction Type'],
      bank: json['Bank'],
      accountnumber: json['Account Number'],
      amount: json['Amount'],
      network: json['Network'],
      accountname: json['Account Name'],
      date: json['Date']);

  Map<String, dynamic> toJson() => {
        'Email': email,
        'Transaction Type': transactiontype,
        'Bank': bank,
        'Account Number': accountnumber,
        'Amount': amount,
        'Network': network,
        'Account Name': accountname,
        'Date': date,
      };
}
