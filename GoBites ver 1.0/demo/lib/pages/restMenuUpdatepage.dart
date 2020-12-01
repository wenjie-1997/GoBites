import 'package:flutter/material.dart';

class RestMenuUpdatePage extends StatefulWidget {
  @override
  _RestMenuUpdatePageState createState() => _RestMenuUpdatePageState();
}

class _RestMenuUpdatePageState extends State<RestMenuUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.red,
        title: Text('Update Menu'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: MenuUpdateForm()),
    );
  }
}

class MenuUpdateForm extends StatefulWidget {
  @override
  _MenuUpdateFormState createState() => _MenuUpdateFormState();
}

class _MenuUpdateFormState extends State<MenuUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: 'xxxxx',
                decoration: const InputDecoration(
                  labelText: 'Menu name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: 'xxxx',
                decoration: const InputDecoration(
                  labelText: 'Price (RM)',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some digit';
                  }
                  return null;
                },
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {},
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
