import 'package:csr/models/notification.dart';
import 'package:csr/screens/alerts/alert_details_screen.dart';
import 'package:csr/services/insuarances.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertItem extends StatelessWidget {
  final AlertNotification alertNotification;
  const AlertItem({Key? key, required this.alertNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AlertDetailsScreen.routeName,
            arguments: alertNotification);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ClipOval(
                    child: Icon(
                      Icons.notifications_active,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alertNotification.title,
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          alertNotification.item,
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          alertNotification.itemNo,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Text('2022-03-22 11:30')
                ],
              ),
              const Divider(),
              Row(
                children: const [
                  Text(
                    'View Details',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    await Provider.of<Insuarances>(context, listen: false)
                        .deleteAllService();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Service confirmed')));
                  },
                  child: const Text('Confirm service'))
            ],
          ),
        ),
      ),
    );
  }
}
