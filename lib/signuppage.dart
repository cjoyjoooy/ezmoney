import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/User.dart';
import 'package:ezmoney/authenticator.dart';
import 'package:ezmoney/models/birthdatefield.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/models/validators.dart';
import 'package:ezmoney/models/passwordtextfield.dart';
import 'package:ezmoney/models/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/signinpage.dart';
import 'package:flutter/material.dart';

import 'models/appstyle.dart';
import 'models/combobox.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

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

  late String errormessage;
  late bool isError;

  final _genderList = ['', 'Male', 'Female', 'Others'];
  String? _selectedGender;

  var _isObscured;
  var _isCPassObscured;

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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _isObscured = true;
    _isCPassObscured = true;
    _selectedGender = _genderList[0];
  }

  Future<void> signUpUser() async {
    if (passwordController.text.trim().length < 6) {
      _showErrorDialog("Password must be at least 6 characters long.");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      addUserData();
    } catch (error) {
      _showErrorDialog("An error occurred during sign-up: $error");
    }
  }

  Future addUserData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userid = user.uid;
    final docUser = FirebaseFirestore.instance.collection('User').doc(userid);
    final newUser = Users(
      id: userid,
      firstname: fnameController.text.trim(),
      lastname: lnameController.text.trim(),
      birthdate: birthdateController.text.trim(),
      gender: _selectedGender!,
      address: addressController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      email: emailController.text.trim(),
      username: usernameController.text.trim(),
      balance: 0,
      image: '',
    );

    final json = newUser.toJson();
    await docUser.set(json);
    goToAuthenticator();
  }

  goToAuthenticator() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Authenticator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(1),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: fontHeader(secondaryColor(1), FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                    txtController: emailController,
                    label: "Email",
                    validator: validateEmail,
                  ),
                  NormalTextField(
                    txtController: usernameController,
                    label: "Username",
                    validator: validateUsername,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  PasswordField(
                    txtController: passwordController,
                    label: "Password",
                    validator: validatePassword,
                    iconVal: _isObscured
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            child: const Icon(Icons.visibility),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            child: const Icon(Icons.visibility_off),
                          ),
                    obscurevalue: _isObscured,
                  ),
                  PasswordField(
                    txtController: confirmPasswordController,
                    label: "Confirm Password",
                    validator: (value) => validateConfirmPassword(
                      value,
                      passwordController,
                      confirmPasswordController,
                    ),
                    iconVal: _isCPassObscured
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCPassObscured = !_isCPassObscured;
                              });
                            },
                            child: const Icon(Icons.visibility),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCPassObscured = !_isCPassObscured;
                              });
                            },
                            child: const Icon(Icons.visibility_off),
                          ),
                    obscurevalue: _isCPassObscured,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    btnLabel: "Sign Up",
                    onPressedMethod: () {
                      if (_formKey.currentState!.validate()) {
                        signUpUser();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style:
                            fontSecondary(secondaryColor(1), FontWeight.w300),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: fontSecondary(accentColor(1), FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
