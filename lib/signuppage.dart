import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/User.dart';
import 'package:ezmoney/authenticator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/signinpage.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  txtFieldStyle2(label, iconVal) => InputDecoration(
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
        suffixIcon: iconVal,
      );

  birthdateStyle(label) => InputDecoration(
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
        suffixIcon: const Icon(Icons.calendar_today_outlined),
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

  @override
  void initState() {
    super.initState();
    _isObscured = true;
    _isCPassObscured = true;
    _selectedGender = _genderList[0];
  }

  Future signUpUser() async {
    if (passwordController.text == confirmPasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      addUserData();
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                TextField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: fnameController,
                  decoration: txtFieldStyle('First Name'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: lnameController,
                  decoration: txtFieldStyle('Last Name'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  readOnly: true,
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: birthdateController,
                  decoration: birthdateStyle('Birthdate'),
                  onTap: () {
                    _selectDate();
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  value: _selectedGender,
                  items: _genderList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedGender = val!;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: secondaryColor(.5),
                  ),
                  decoration: comboBoxStyle('Gender'),
                  dropdownColor: primaryColor(1),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: addressController,
                  decoration: txtFieldStyle('Address'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: phoneNumberController,
                  decoration: txtFieldStyle('Phone Number'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: emailController,
                  decoration: txtFieldStyle('Email'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  style: fontDefault(secondaryColor(1), FontWeight.w500),
                  controller: usernameController,
                  decoration: txtFieldStyle('Username'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: _isObscured,
                  style: fontDefault(secondaryColor(.9), FontWeight.w500),
                  decoration: txtFieldStyle2(
                    'Password',
                    _isObscured
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
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: _isCPassObscured,
                  style: fontDefault(secondaryColor(.9), FontWeight.w500),
                  decoration: txtFieldStyle2(
                    'Confirm Password',
                    _isCPassObscured
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
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: btnStyle(accentColor(1), primaryColor(1)),
                  onPressed: () {
                    signUpUser();
                  },
                  child: const Text(
                    "Sign Up",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: fontSecondary(secondaryColor(1), FontWeight.w300),
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
        ],
      ),
    );
  }
}
