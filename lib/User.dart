class Users {
  final String id;
  final String firstname;
  final String lastname;
  final String birthdate;
  final String gender;
  final String address;
  final String phoneNumber;
  final String email;
  final String username;
  final double balance;
  final String image;

  Users({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.username,
    required this.balance,
    required this.image,
  });

  static Users fromJson(Map<String, dynamic> json) => Users(
        id: json['id'],
        firstname: json['First Name'],
        lastname: json['Last Name'],
        birthdate: json['Birthdate'],
        gender: json['Gender'],
        address: json['Address'],
        phoneNumber: json['Phone Number'],
        email: json['Email'],
        username: json['Username'],
        balance: json['Balance'],
        image: json['Image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'First Name': firstname,
        'Last Name': lastname,
        'Birthdate': birthdate,
        'Gender': gender,
        'Address': address,
        'Phone Number': phoneNumber,
        'Email': email,
        'Username': username,
        'Balance': balance,
        'Image': image,
      };
}
