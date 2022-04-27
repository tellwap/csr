import 'package:csr/services/auths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 70,
                    color: Colors.white,
                  ),
                  Text(
                    '${user?.firstName}, ${user?.lastName}',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
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
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => _logout(context), child: Text('Logout')))
        ],
      ),
    );
  }
}
