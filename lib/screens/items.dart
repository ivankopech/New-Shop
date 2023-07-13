import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_shop_app/screens/add_item.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});
  static const routeName = 'items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My items'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddItemScreen(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Text('Hear you\'ll see all your items!'),
      ),
    );
  }
}
