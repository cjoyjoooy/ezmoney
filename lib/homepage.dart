import '/accountscreen.dart';
import '/homescreen.dart';
import '/notification.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        fontSize: 32,
        color: colorVal,
        fontWeight: weightVal,
        letterSpacing: 1.1,
      );

  int _currentIndex = 0;

  final screens = [
    HomeScreen(),
    Notifications(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor(1),
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: primaryColor(1),
            iconSize: 36,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: secondaryColor(.4),
            selectedItemColor: accentColor(1),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: "",
                backgroundColor: accentColor(1),
                activeIcon: const Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications_none_rounded),
                label: "",
                backgroundColor: accentColor(1),
                activeIcon: const Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                label: "",
                backgroundColor: accentColor(1),
                activeIcon: const Icon(Icons.account_circle),
              ),
            ],
          ),
        ));
  }
}
