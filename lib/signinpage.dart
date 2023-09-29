import '/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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

  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late String errormessage;
  late bool isError;

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
      body: Container(
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
            TextField(
              style: fontDefault(secondaryColor(.9), FontWeight.w500),
              controller: usernamecontroller,
              decoration: txtFieldStyle('Username'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              obscureText: _isObscured,
              style: fontDefault(secondaryColor(.9), FontWeight.w500),
              controller: passwordcontroller,
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
              onPressed: () {
                checkLogin(
                  usernamecontroller.text,
                  passwordcontroller.text,
                );
                /* Temporary Comment
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Home()),
                ); */
              },
              child: const Text(
                "Sign In",
              ),
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
    );
  }
}
