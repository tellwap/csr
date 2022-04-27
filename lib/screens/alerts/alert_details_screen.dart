import 'package:csr/models/notification.dart';
import 'package:flutter/material.dart';

class AlertDetailsScreen extends StatelessWidget {
  const AlertDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/alert-details-screen';

  @override
  Widget build(BuildContext context) {
    final notification =
        ModalRoute.of(context)?.settings.arguments as AlertNotification;
    return Scaffold(
      appBar: AppBar(
        title: Text(notification.title),
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Car Name'),
                  Text(
                    notification.item,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Plate No'),
                  Text(
                    notification.itemNo,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service Type'),
                  Text(
                    notification.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date'),
                  Text(
                    '2022-04-27 11:12',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
