import 'package:csr/models/car.dart';
import 'package:csr/screens/list_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = [
      Car(name: 'Landcruiser', plateNo: 'TZ-345-433'),
      Car(name: 'Fusso', plateNo: 'TZ-433-768'),
      Car(name: 'Toyota Ist', plateNo: 'TZ-675-345'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) => ListTile(
                leading: const Icon(
                  Icons.directions_car_rounded,
                  size: 50,
                ),
                title: Text(
                  cars[index].name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  cars[index].plateNo,
                  style: const TextStyle(fontSize: 18),
                ),
                // trailing: Text('Offline'),
                onTap: () {
                  Navigator.pushNamed(context, ListDetailsScreen.routeName,
                      arguments: cars[index]);
                },
              )),
    );
  }
}
