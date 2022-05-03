import 'package:csr/models/api_response.dart';
import 'package:csr/screens/add_car_screen.dart';
import 'package:csr/screens/list_details_screen.dart';
import 'package:csr/services/cars.dart';
import 'package:csr/widgets/loading.dart';
import 'package:csr/widgets/no_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cars = Provider.of<Cars>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: FutureBuilder(
          future: Provider.of<Cars>(context, listen: false).getCars(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            final _apiResponse = snapshot.data as ApiResponse;
            if (_apiResponse.error != null) {
              return NoItem(message: _apiResponse.error.toString());
            }
            // if (cars.isEmpty) {
            //   return const NoItem(message: 'No car added');
            // }
            return Consumer<Cars>(
              builder: (contex, data, child) => data.items.isEmpty
                  ? const NoItem(message: 'No car added')
                  : ListView.builder(
                      itemCount: data.items.length,
                      itemBuilder: (context, index) => ListTile(
                            leading: const Icon(
                              Icons.directions_car_rounded,
                              size: 50,
                            ),
                            title: Text(
                              data.items[index].name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data.items[index].plateNo,
                              style: const TextStyle(fontSize: 18),
                            ),
                            // trailing: Text('Offline'),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ListDetailsScreen.routeName,
                                  arguments: data.items[index]);
                            },
                          )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddCarScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
