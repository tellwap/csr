import 'package:csr/screens/add_car_screen.dart';
import 'package:csr/screens/add_insuarance_screen.dart';
import 'package:csr/screens/alerts/alert_details_screen.dart';
import 'package:csr/screens/alerts/alert_screen.dart';
import 'package:csr/screens/auths/login_screen.dart';
import 'package:csr/screens/auths/register_screen.dart';
import 'package:csr/screens/bottom_navigation_screen.dart';
import 'package:csr/screens/list_details_screen.dart';
import 'package:csr/screens/splash_screen.dart';
import 'package:csr/services/alerts.dart';
import 'package:csr/services/auths.dart';
import 'package:csr/services/cars.dart';
import 'package:csr/services/insuarances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
//import 'package:workmanager/workmanager.dart';

//this is the given to the background fetch
const simplePeriodicTask = 'simplePeriodicTask';

void showNotification(v, flp) async {
  var android = const AndroidNotificationDetails(
      'channelId', ' channelName', 'channelDescription',
      priority: Priority.high, importance: Importance.max);
  var ios = const IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: ios);
  await flp.show(0, 'Example of notification', '$v', platform,
      payload: 'VIS \n $v');
}

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callBackDispatcher, isInDebugMode: true);
  // await Workmanager().registerPeriodicTask('s', simplePeriodicTask,
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     frequency: Duration(seconds: 5),
  //     initialDelay: Duration(seconds: 5),
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ));
  runApp(const MyApp());
}

// void callBackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//     print('running every 15 minutes');
//     return Future.value(true);
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Cars()),
        ChangeNotifierProvider(create: (ctx) => Insuarances()),
        ChangeNotifierProvider(create: (ctx) => Alerts()),
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
            AlertScreen.routeName: (context) => const AlertScreen(),
            AddCarScreen.routeName: (ctx) => const AddCarScreen(),
            AddInsuaranceScreen.routeName: (ctx) => const AddInsuaranceScreen(),
          },
        ),
      ),
    );
  }
}
