import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'User.dart';
import 'models/appstyle.dart';
import 'models/birthdatefield.dart';
import 'models/combobox.dart';
import 'models/textfield.dart';
import 'models/validators.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _SignUpState();
}

class _SignUpState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? birthdate,
    String? gender,
    String? address,
    String? phoneNumber,
    String? email,
    String? username,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDocRef =
            FirebaseFirestore.instance.collection('User').doc(user.uid);

        // Create a map of fields to update
        final Map<String, dynamic> updatedFields = {};
        if (firstName != null) updatedFields['First Name'] = firstName;
        if (lastName != null) updatedFields['Last Name'] = lastName;
        if (birthdate != null) updatedFields['Birthdate'] = birthdate;
        if (gender != null) updatedFields['Gender'] = gender;
        if (address != null) updatedFields['Address'] = address;
        if (phoneNumber != null) updatedFields['Phone Number'] = phoneNumber;
        if (email != null) updatedFields['Email'] = email;
        if (username != null) updatedFields['Username'] = username;

        // Update the user document with the provided fields
        await userDocRef.update(updatedFields);

        // Success message
        print('User profile updated successfully');
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Error updating user profile: $e');
      // Handle error gracefully
    }
  }

  Future<Users> getUserData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.uid;

    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('User').doc(userId).get();

    if (snapshot.exists) {
      return Users.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      throw Exception("User data not found");
    }
  }

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? _selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (_selected != null) {
      setState(() {
        birthdateController.text = _selected.toString().split(" ")[0];
      });
    }
  }

  final _genderList = ['', 'Male', 'Female', 'Others'];
  String? _selectedGender;

  var _isObscured;

  @override
  void initState() {
    super.initState();

    getUserData().then((userData) {
      setState(() {
        fnameController.text = userData.firstname;
        lnameController.text = userData.lastname;
        birthdateController.text = userData.birthdate;
        _selectedGender = userData.gender;
        addressController.text = userData.address;
        phoneNumberController.text = userData.phoneNumber;
        emailController.text = userData.email;
        usernameController.text = userData.username;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerTheme:
              const DividerThemeData(space: 0.0, color: Colors.transparent)),
      child: Scaffold(
        backgroundColor: primaryColor(1),
        appBar: AppBar(
          title: Text(
            'Edit Profile',
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
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalTextField(
                      txtController: fnameController,
                      label: "First Name",
                      validator:
                          validateFirstName, // Now you can use the function directly
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: lnameController,
                      label: "Last Name",
                      validator: validateLastName,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BirthDateField(
                      txtController: birthdateController,
                      onTapMethod: () {
                        _selectDate();
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ComboBox(
                      label: "Gender",
                      value: _selectedGender,
                      itemList: _genderList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChangeValue: (val) {
                        setState(() {
                          _selectedGender = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: addressController,
                      label: "Address",
                      validator: validateAddress,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: phoneNumberController,
                      label: "Phone Number",
                      validator: validatePhoneNumber,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalTextField(
                      txtController: usernameController,
                      label: "Username",
                      validator: validateUsername,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
            child: Button(
              btnLabel: "Save",
              onPressedMethod: () {
                if (_formKey.currentState!.validate()) {}
                updateUserProfile(
                  firstName: fnameController.text,
                  lastName: lnameController.text,
                  birthdate: birthdateController.text,
                  gender: _selectedGender!,
                  address: addressController.text,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                  username: usernameController.text,
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
