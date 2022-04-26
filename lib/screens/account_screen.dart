import 'package:flutter/material.dart';
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 50),
              child: Row(
                children: const [
                  Icon(Icons.account_circle_outlined,size: 70,),
                  Text('Chami', style: TextStyle(fontSize: 30),)
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 10,top:10,right: 10),
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text('Select Language'),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text('Alarm Push'),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text('About'),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
          ),
          SizedBox(height: 20,),
          Container(
              margin: EdgeInsets.all(20),
              width:double.infinity,
              child: ElevatedButton(onPressed: (){}, child: Text('Logout')))
        ],
      ),
    );
  }
}
