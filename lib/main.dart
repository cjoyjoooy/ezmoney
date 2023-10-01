import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ezmoney/models/appstyle.dart';
import 'package:page_transition/page_transition.dart';
import '/startpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(155, 128, 231, 1)),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: 'images/EZLOGO 2.png',
        duration: 6000,
        pageTransitionType: PageTransitionType.bottomToTop,
        nextScreen: StartPage(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: primaryColor(1),
      ),
    );
  }
}
