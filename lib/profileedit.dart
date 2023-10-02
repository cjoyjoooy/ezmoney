import 'package:ezmoney/models/buttonStyle.dart';
import 'package:flutter/material.dart';

import 'models/appstyle.dart';
import 'models/birthdatefield.dart';
import 'models/combobox.dart';
import 'models/passwordtextfield.dart';
import 'models/textfield.dart';
import 'models/validators.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _SignUpState();
}

class _SignUpState extends State<EditProfile> {
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
    _isObscured = true;
    _selectedGender = _genderList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    btnLabel: "Save",
                    onPressedMethod: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
