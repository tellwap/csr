import 'package:csr/models/api_response.dart';
import 'package:csr/models/car.dart';
import 'package:csr/screens/add_insuarance_screen.dart';
import 'package:csr/services/insuarances.dart';
import 'package:csr/widgets/loading.dart';
import 'package:csr/widgets/no_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
      body: FutureBuilder(
          future: Provider.of<Insuarances>(context, listen: false)
              .getInsuarances(car.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            final _apiResponse = snapshot.data as ApiResponse;
            if (_apiResponse.error != null) {
              return NoItem(message: _apiResponse.error.toString());
            }
            return Card(
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Service Mileage'),
                        Text(
                          '2000 Km',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Current Mileage'),
                        Text(
                          '${car.currentMileage} Km',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Mileage Remaining'),
                        Text(
                          '${(2000 - car.currentMileage)} Km',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date Added'),
                        Text(
                          DateFormat.yMEd()
                              .add_jms()
                              .format(DateTime.parse(car.createdAt)),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Consumer<Insuarances>(
                        builder: (ctx, data, child) => ListView.builder(
                            itemCount: data.items.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                title: Text(
                                  data.items[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(data.items[index].expireDate
                                    .toIso8601String()),
                              );
                            }),
                      ),
                    ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddInsuaranceScreen.routeName,
              arguments: car);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
