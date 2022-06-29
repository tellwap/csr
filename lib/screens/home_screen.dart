import 'package:csr/screens/alerts/alert_screen.dart';
import 'package:csr/services/auths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<Auth>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text(
                      'Total Device',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '3',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/car.png',
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AlertScreen.routeName);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: const [
                            Text(
                              'Service Alert',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Service alert details')
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AlertScreen.routeName);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: const [
                            Text(
                              'Insurance Alert',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Insurance expired alert')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                FlutterLocalNotificationsPlugin flp =
                    FlutterLocalNotificationsPlugin();
                var android =
                    const AndroidInitializationSettings('@mipmap/ic_launcher');
                var ios = const IOSInitializationSettings();
                var initSettings =
                    InitializationSettings(android: android, iOS: ios);
                flp.initialize(initSettings);

                showNotification('message to show', flp);
              },
              child: const Text('show notification'))
        ],
      ),
    );
  }

  void showNotification(v, flp) async {
    var android = const AndroidNotificationDetails(
        'channelId', ' channelName', 'channelDescription',
        priority: Priority.high, importance: Importance.max);
    var ios = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    await flp.show(0, 'Example of notification', '$v', platform,
        payload: 'VIS \n $v');
  }
}
