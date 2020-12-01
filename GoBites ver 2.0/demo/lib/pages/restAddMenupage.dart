import 'package:flutter/material.dart';

class RestAddMenuPage extends StatefulWidget {
  @override
  _RestAddMenuPageState createState() => _RestAddMenuPageState();
}

class _RestAddMenuPageState extends State<RestAddMenuPage> {
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
        title: Text('Add Menu'),
        centerTitle: true,
      ),
      body: RestAddMenuForm(),
    );
  }
}

class RestAddMenuForm extends StatefulWidget {
  @override
  _RestAddMenuFormState createState() => _RestAddMenuFormState();
}

class _RestAddMenuFormState extends State<RestAddMenuForm> {
  
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
                decoration: const InputDecoration(
                  labelText: 'Menu Name',
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
              onPressed: () {
              },
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
