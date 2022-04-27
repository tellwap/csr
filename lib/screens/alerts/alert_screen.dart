import 'package:csr/models/notification.dart';
import 'package:csr/widgets/alert_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);
  static const routeName = '/alert-screen';

  @override
  Widget build(BuildContext context) {
    final notifications = [
      AlertNotification(
          title: 'Service alert', item: 'Landcruiser', itemNo: 'TZ-234-454'),
      AlertNotification(
          title: 'Insuarance expired alert',
          item: 'Fusso',
          itemNo: 'TZ-322-324'),
      AlertNotification(
          title: 'TRA sticker expired',
          item: 'Toyota ist',
          itemNo: 'TZ-435-454'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert'),
      ),
      body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) => AlertItem(
                alertNotification: notifications[index],
              )),
    );
  }
}
