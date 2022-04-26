import 'package:csr/screens/account_screen.dart';
import 'package:csr/screens/alert_screen.dart';
import 'package:csr/screens/home_screen.dart';
import 'package:csr/screens/list_screens.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);
  static const routeName = 'bottom-navigation-screen';

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> pages = [
    const HomeScreen(),
    const ListScreen(),
    const AlertScreen(),
    const AccountScreen()
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: 'Alerts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'Me'),
          ],

          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: pages[_currentIndex]);
  }
}
