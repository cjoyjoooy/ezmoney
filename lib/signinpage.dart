import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/models/passwordtextfield.dart';
import 'package:ezmoney/models/textfield.dart';
import 'package:ezmoney/models/validators.dart';
import '/signuppage.dart';
import 'models/appstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  late String errormessage;
  late bool isError;

  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future checkLogin(username, password) async {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      setState(() {
        errormessage = "";
      });
    } on FirebaseAuthException catch (e) {
      print(e);

      setState(() {
        errormessage = e.message.toString();
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 1,
              image: AssetImage("images/mobileBackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Hello there,",
                style: fontHeader(secondaryColor(1), FontWeight.bold),
              ),
              Text(
                "Welcome back",
                style: fontHeader(secondaryColor(1), FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              NormalTextField(
                txtController: usernamecontroller,
                label: "Email",
                validator: validateEmail,
              ),
              const SizedBox(
                height: 5,
              ),
              PasswordField(
                txtController: passwordcontroller,
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
                btnLabel: "Sign In",
                onPressedMethod: () {
                  if (_formKey.currentState!.validate()) {
                    checkLogin(
                      usernamecontroller.text,
                      passwordcontroller.text,
                    );
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
                    "Don't have an account?",
                    style: fontSecondary(secondaryColor(1), FontWeight.w300),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: fontSecondary(accentColor(1), FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
