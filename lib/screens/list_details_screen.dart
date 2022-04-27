import 'package:csr/models/car.dart';
import 'package:flutter/material.dart';

class ListDetailsScreen extends StatelessWidget {
  const ListDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/list-details-screen';

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)?.settings.arguments as Car;
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Car Name'),
                  Text(
                    car.name,
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
                    car.plateNo,
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
