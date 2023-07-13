import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/user_info_screen.dart';
import '../screens/items.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Choose an option'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My data'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const UserInfoScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.adb_outlined),
            title: Text('My items'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ItemsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
