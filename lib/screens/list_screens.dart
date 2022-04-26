import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List'),),

      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => const ListTile(
                leading: Icon(Icons.directions_car_rounded,size: 50,),
                title: Text('Land cruiser',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text('Imei 434543434',style: TextStyle(fontSize: 18),),
                trailing: Text('Offline'),
              )),
    );
  }
}
