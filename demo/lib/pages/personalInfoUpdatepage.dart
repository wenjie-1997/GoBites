import 'package:flutter/material.dart';

class PersonalInfoUpdatePage extends StatefulWidget {
  @override
  _PersonalInfoUpdatePageState createState() => _PersonalInfoUpdatePageState();
}

class _PersonalInfoUpdatePageState extends State<PersonalInfoUpdatePage> {
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
      body: SingleChildScrollView(child: PersonalUpdateForm()),
    );
  }
}

class PersonalUpdateForm extends StatefulWidget {
  @override
  _PersonalUpdateFormState createState() => _PersonalUpdateFormState();
}

class _PersonalUpdateFormState extends State<PersonalUpdateForm> {
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
                initialValue: 'XXX XXX XXX',
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                initialValue: 'abc@gmail.com',
                decoration: const InputDecoration(
                  labelText: 'Email Address',
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
