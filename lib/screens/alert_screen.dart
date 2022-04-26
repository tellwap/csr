import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alert'),),
      body: ListView.builder(
         itemCount: 3,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children:  [
                          const ClipOval(
                            child: Icon(
                              Icons.notifications_active,
                              size: 40,
                            ),
                          ),
                          const SizedBox(width:20,),
                          Expanded(child:   Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Power cut off alarm', style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text('Power cut off alarm', style: TextStyle(fontSize: 17),),
                              SizedBox(height: 10,),
                              Text('Power cut off alarm', style: TextStyle(fontSize: 17),),
                            ],
                          ),),

                          Text('2022-03-22 11:30')
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: const [
                          Text('View Details',style: TextStyle(
                            fontSize: 16
                          ),),
                          Spacer(),
                          Icon(Icons.chevron_right_outlined)
                        ],
                      )

                    ],
                  ),
                ),
              )),
    );
  }
}
