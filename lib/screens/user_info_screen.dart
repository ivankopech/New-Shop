import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  static const routeName = 'user-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My information'),
      ),
      body: Center(
        child: Text('Here you will find all your data!'),
      ),
    );
  }
}
