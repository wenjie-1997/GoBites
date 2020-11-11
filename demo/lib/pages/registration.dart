import 'dart:ui';

/// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

/// This is the main application widget.
class _RegisterState extends State<Register> {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Register an Account'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String usertype;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Username:',
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
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
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Password:',
                  ),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your Password',
                ),
                validator: (value) {
                  if (value.length < 8 || value.length > 15) {
                    return 'The length of the password must be from 8 to 15.';
                  }
                  return null;
                },
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'User Type:',
                  ),
                ),
              ),
              ListTile(
                title: const Text('Customer'),
                leading: Radio(
                  value: 'Customer',
                  groupValue: usertype,
                  onChanged: (String value) {
                    setState(() {
                      usertype = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Restaurant'),
                leading: Radio(
                  value: 'Restaurant',
                  groupValue: usertype,
                  onChanged: (String value) {
                    setState(() {
                      usertype = value;
                    });
                  },
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
