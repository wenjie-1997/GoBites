/// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.
import 'dart:convert';
import 'package:demo/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';
import 'package:date_format/date_format.dart';

String username;
String password;
String usertype;
DateTime birthdate;
String custname;
String gender;
String email;
String address;
String telephoneNo;
String restaurantname;
String ownername;
String restaurantstyle;

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
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegistrationFormState extends State<RegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(children: <Widget>[
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value.length < 8 || value.length > 15) {
                    return 'The length of the password must be from 8 to 15.';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'User Type:',
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio(
                    value: 'customer',
                    groupValue: usertype,
                    onChanged: (String value) {
                      setState(() {
                        usertype = value;
                      });
                    },
                  ),
                  Text('Customer'),
                  Radio(
                    value: 'restaurant',
                    groupValue: usertype,
                    onChanged: (String value) {
                      setState(() {
                        usertype = value;
                      });
                    },
                  ),
                  Text('Restaurant'),
                ],
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (usertype == "customer") {
                    // If the form is valid, display a Snackbar.
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CusRegistrationForm()));
                  } else if (usertype == "restaurant") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RestRegistrationForm()));
                  }
                }
              },
              child: Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

class CusRegistrationForm extends StatefulWidget {
  @override
  CusRegistrationFormState createState() {
    return CusRegistrationFormState();
  }
}

class CusRegistrationFormState extends State<CusRegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  Future customerRegister() async {
    final formattedbirthdate = formatDate(birthdate, [yyyy, '-', m, '-', dd]);
    final msg = jsonEncode({
      "username": username,
      "password": password,
      "usertype": usertype,
      "custname": custname,
      "birthdate": formattedbirthdate,
      "gender": gender,
      "address": address,
      "email": email,
      "telephoneNo": telephoneNo
    });
    final result = await http_post("/custregister", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
    if (status == "Register Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Resgister Successful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      // AlertDialog(
      //   title: Text(status),
      //   actions: <Widget>[
      //     TextButton(
      //       child: Text('Continue'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: birthdate != null ? birthdate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != birthdate)
      setState(() {
        birthdate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(title: Text('Customer Registration')),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Customer Name',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your user name';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          custname = value;
                        });
                      },
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Gender:',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: gender,
                          onChanged: (String value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                        Text('Male'),
                        Radio(
                          value: 'Female',
                          groupValue: gender,
                          onChanged: (String value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    )
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Birthday:',
                        ),
                      ),
                    ),
                    Row(children: [
                      Text("${birthdate != null ? birthdate.toLocal() : ''}"
                          .split(' ')[0]),
                      Material(
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today_sharp,
                            ),
                            color: Colors.black,
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(children: <Widget>[
                    TextFormField(
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'Enter your address here.',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Telephone No.',
                        hintText: 'Telephone No.:',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          telephoneNo = value;
                        });
                      },
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        customerRegister();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class RestRegistrationForm extends StatefulWidget {
  @override
  RestRegistrationFormState createState() {
    return RestRegistrationFormState();
  }
}

class RestRegistrationFormState extends State<RestRegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  Future restaurantRegister() async {
    final msg = jsonEncode({
      "username": username,
      "password": password,
      "usertype": usertype,
      "restaurantname": restaurantname,
      "ownername": ownername,
      "address": address,
      "restaurantstyle": restaurantstyle,
      "email": email,
      "telephoneNo": telephoneNo,
    });
    final result = await http_post("/restregister", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
    if (status == "Register Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Resgister Successful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      // AlertDialog(
      //   title: Text(status),
      //   actions: <Widget>[
      //     TextButton(
      //       child: Text('Continue'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(title: Text('Customer Registration')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Restaurant Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the restaurant name';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    setState(() {
                      restaurantname = value;
                    })
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Restaurant Owner Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the restaurant owner name';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    setState(() {
                      ownername = value;
                    })
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: TextFormField(
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Restaurant Address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the restaurant address';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    setState(() {
                      address = value;
                    })
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Restaurant type/style',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        value: restaurantstyle,
                        //icon: Icon(Icons.arrow_downward),
                        //iconSize: 24,
                        //elevation: 16,
                        //style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            restaurantstyle = newValue;
                          });
                        },
                        items: <String>[
                          'Malay',
                          'Chinese',
                          'Indian',
                          'Western',
                          'Arabic',
                          'Others'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Telephone No.',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        telephoneNo = value;
                      });
                    },
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      restaurantRegister();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
