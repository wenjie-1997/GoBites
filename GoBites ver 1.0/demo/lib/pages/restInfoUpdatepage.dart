import 'package:flutter/material.dart';

class RestInfoUpdatePage extends StatefulWidget {
  @override
  _RestInfoUpdatePageState createState() => _RestInfoUpdatePageState();
}

class _RestInfoUpdatePageState extends State<RestInfoUpdatePage> {
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
        title: Text('Update Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: RestUpdateForm()),
    );
  }
}

class RestUpdateForm extends StatefulWidget {
  @override
  _RestUpdateFormState createState() => _RestUpdateFormState();
}

class _RestUpdateFormState extends State<RestUpdateForm> {
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
                  labelText: 'Username',
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
                  labelText: 'Password',
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
                initialValue: 'McDonald\'s',
                decoration: const InputDecoration(
                  labelText: 'Restaurant Name',
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
                initialValue: 'abc@hotmail.com',
                decoration: const InputDecoration(
                  labelText: 'E-mail Address',
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
                initialValue: 'XXX XXX XXX',
                decoration: const InputDecoration(
                  labelText: 'Restaurant Owner Name',
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
                initialValue: 'chinese',
                decoration: const InputDecoration(
                  labelText: 'Restaurant Type/Style',
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
                initialValue: 'xxxxx',
                decoration: const InputDecoration(
                  labelText: 'Address',
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
