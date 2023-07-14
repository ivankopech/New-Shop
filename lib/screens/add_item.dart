import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _form = GlobalKey<FormState>();

  var _enteredName = '';
  var _enteredOriginAddress = '';
  var _enteredDestinationAddress = '';
  var _enteredHeight = '';
  var _enteredWeight = '';
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add item'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_alt_outlined),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            key: _form,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                autocorrect: false,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 4) {
                    return 'Plase enter a valid email name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Origin address'),
                autocorrect: false,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 5) {
                    return 'Plase enter a valid address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredOriginAddress = value!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Destination address'),
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Please enter a valid address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredDestinationAddress = value!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                autocorrect: false,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 1) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredWeight = value!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height'),
                autocorrect: false,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 1) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredHeight = value!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
