/// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.
import 'dart:convert';
import 'dart:ui';
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
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orange[600],
      ),
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
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow[100], Colors.orange[200]])),
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(top: 50, left: 20),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.orange,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Login()),
                                  (route) => false),
                              icon:
                                  Icon(Icons.arrow_back, color: Colors.white)),
                        ))),
                RegistrationForm(),
              ],
            ))));
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  Future checkUsername() async {
    final msg = jsonEncode({
      "username": username,
    });
    final result = await http_post("/checkusername", msg);
    String status = jsonDecode(result.body);
    if (status == "Username does not exist") {
      if (usertype == "customer") {
        // If the form is valid, display a Snackbar.
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new CusRegistrationForm()));
      } else if (usertype == "restaurant") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new RestRegistrationForm()));
      }
    } else {
      Future(() {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => new AlertDialog(
                  title: Text("Username exists!"),
                  content: Text("Please try to type a different username."),
                  actions: <Widget>[
                    TextButton(
                        child: Text('Continue'),
                        onPressed: () => Navigator.of(context).pop()),
                  ],
                ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Register Now",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Username",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your user name';
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                decoration: textFieldDecoration(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 7 || value.length > 18) {
                    return 'The length of the password is between 7 and 18.';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("User Type",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                  Text(
                    'Customer',
                    style: TextStyle(fontSize: 15),
                  ),
                  Radio(
                    value: 'restaurant',
                    groupValue: usertype,
                    onChanged: (String value) {
                      setState(() {
                        usertype = value;
                      });
                    },
                  ),
                  Text(
                    'Restaurant',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.orange.withOpacity(0.5);
                      return Colors.orange; // Use the component's default.
                    },
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    checkUsername();
                  }
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ));
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
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => new Login()),
          (route) => false);
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
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow[100], Colors.orange[200]])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(top: 50, left: 20),
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.orange,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon:
                                  Icon(Icons.arrow_back, color: Colors.white)),
                        ))),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Customer Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Customer Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: textFieldDecoration(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Gender",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
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
                            Text(
                              'Male',
                              style: TextStyle(fontSize: 15),
                            ),
                            Radio(
                              value: 'Female',
                              groupValue: gender,
                              onChanged: (String value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Birthday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  "${birthdate != null ? birthdate.toLocal().toString().split(' ')[0] : 'Please select the date'}",
                                  style: TextStyle(fontSize: 15)),
                              Material(
                                child: Center(
                                    child: Container(
                                  color: Colors.yellow[200],
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.calendar_today_sharp,
                                    ),
                                    color: Colors.black,
                                    onPressed: () => _selectDate(context),
                                  ),
                                )),
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 6,
                          decoration: textFieldDecoration(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Telephone No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: textFieldDecoration(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: textFieldDecoration(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.orange.withOpacity(0.5);
                                  return Colors
                                      .orange; // Use the component's default.
                                },
                              ),
                            ),
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
                )
              ],
            ))));
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
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => new Login()),
          (route) => false);
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
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow[100], Colors.orange[200]])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Column(children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.orange,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back, color: Colors.white)),
                    ))),
            Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Restaurant Detail",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Restaurant Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: textFieldDecoration(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Owner Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: textFieldDecoration(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 6,
                        decoration: textFieldDecoration(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Restaurant type/style",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButtonFormField<String>(
                          value: restaurantstyle,
                          validator: (value) => value == null
                              ? 'Please select one restaurant style'
                              : null,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          decoration: textFieldDecoration(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Telephone No.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: textFieldDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter  the telephone no.';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            telephoneNo = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: textFieldDecoration(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.orange.withOpacity(0.5);
                                return Colors
                                    .orange; // Use the component's default.
                              },
                            ),
                          ),
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
                )),
          ])),
        ));
  }
}

InputDecoration textFieldDecoration() {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    filled: true,
    fillColor: Colors.white70,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
  );
}
