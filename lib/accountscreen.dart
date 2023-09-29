import 'package:cloud_firestore/cloud_firestore.dart';
import '/profileedit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  primaryColor(double opacityVal) => Color.fromRGBO(20, 18, 28, opacityVal);
  secondaryColor(double opacityVal) =>
      Color.fromRGBO(250, 250, 250, opacityVal);
  accentColor(double opacityVal) => Color.fromRGBO(155, 128, 231, opacityVal);
  tertiaryColor(double opacityVal) => Color.fromRGBO(34, 33, 46, opacityVal);
  deleteColor(double opacityVal) => Color.fromRGBO(243, 36, 36, opacityVal);

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

  Future deleteUser(String id) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    docUser.delete();
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
          title: Text(
            'Profile',
            style: fontTertiary(secondaryColor(1), FontWeight.bold),
          ),
          centerTitle: true,
          surfaceTintColor: primaryColor(1),
          backgroundColor: primaryColor(1),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 32,
                    color: secondaryColor(1),
                  )),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: ListView(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 85,
                    color: Color.fromRGBO(250, 250, 250, 1),
                  ),
                  Text(
                    'Lex Vincent Jyff Lao',
                    style: fontDefault(
                      secondaryColor(1),
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Birthdate',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    'September 30, 2001',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    'Male',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    'Tandag, Surigao del Sur',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    'L.Lao.52484@umindanao.edu.ph',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '0912387645',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    'Lexu69420',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '************',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                ElevatedButton(
                  style: btnStyle(accentColor(1), primaryColor(1)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  child: const Text(
                    "Edit Profile",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    textAlign: TextAlign.center,
                    'Delete Account',
                    style: fontTertiary(deleteColor(1), FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
