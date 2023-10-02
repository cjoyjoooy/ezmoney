import '/accountscreen.dart';
import '/homescreen.dart';
import 'package:flutter/material.dart';

import 'models/appstyle.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final screens = [
    HomeScreen(),
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
