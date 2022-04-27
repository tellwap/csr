import 'package:csr/screens/alerts/alert_details_screen.dart';
import 'package:csr/screens/alerts/alert_screen.dart';
import 'package:csr/screens/auths/login_screen.dart';
import 'package:csr/screens/auths/register_screen.dart';
import 'package:csr/screens/bottom_navigation_screen.dart';
import 'package:csr/screens/list_details_screen.dart';
import 'package:csr/screens/splash_screen.dart';
import 'package:csr/services/auths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? const BottomNavigationScreen()
              : FutureBuilder<Object>(
                  future: auth.tryAutoLogin(),
                  builder: (context, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const LoginScreen()),
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            BottomNavigationScreen.routeName: (context) =>
                const BottomNavigationScreen(),
            AlertDetailsScreen.routeName: (context) =>
                const AlertDetailsScreen(),
            ListDetailsScreen.routeName: (context) => const ListDetailsScreen(),
            AlertScreen.routeName: (context) => const AlertScreen()
          },
        ),
      ),
    );
  }
}
