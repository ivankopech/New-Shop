import 'package:flutter/material.dart';

import '../screens/user_info_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello user!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('My data'),
              onTap: () {
                Navigator.of(context).pushNamed(UserInfoScreen.routeName);
              }),
        ],
      ),
    );
  }
}
