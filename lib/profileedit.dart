import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _SignUpState();
}

class _SignUpState extends State<EditProfile> {
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

  genderStyle(label) => InputDecoration(
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

  final _genderList = ['Male', 'Female', 'Others'];
  String? _selectedGender;

  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      _selectedGender = val as String;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: secondaryColor(.5),
                  ),
                  decoration: genderStyle('Gender'),
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
                  height: 30,
                ),
                ElevatedButton(
                  style: btnStyle(accentColor(1), primaryColor(1)),
                  onPressed: () {},
                  child: const Text(
                    "Save",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
