import 'package:csr/models/notification.dart';
import 'package:csr/services/alerts.dart';
import 'package:csr/widgets/alert_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);
  static const routeName = '/alert-screen';

  @override
  Widget build(BuildContext context) {
    final alerts = Provider.of<Alerts>(context, listen: false).items;
    var totalDistance = 0;
    List<AlertNotification> notifications = [];
    for (var alert in alerts) {
      totalDistance += alert.distance;
      print(alert.distance);
    }

    int totalAlert = (totalDistance / 10000).floor();
    for (int i = 0; i < totalAlert; ++i) {
      notifications.add(
        AlertNotification(
            title: 'Service alert',
            item: 'Land cruiser',
            itemNo: 'T 236 BZZ',
            date: DateTime.now().add(Duration(hours: (24 * i)))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert'),
      ),
      body: FutureBuilder(
        future: Provider.of<Alerts>(context, listen: false).getAlerts(),
        builder: (ctx, snapshot) => ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) => AlertItem(
                  alertNotification: notifications[index],
                )),
      ),
    );
  }
}
