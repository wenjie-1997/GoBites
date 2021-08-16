/// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/register/register_viewmodel.dart';
import 'package:gobites/screens/view.dart';
import 'package:gobites/screens/viewmodel.dart';

// String username;
// String password;
// String usertype;
// DateTime birthdate;
// String custname;
// String gender;
// String email;
// String address;
// String telephoneNo;
// String restaurantname;
// String ownername;
// String restaurantstyle;

class Register extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => Register());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
      viewmodel: dependency<RegisterViewmodel>(),
      builder: (context, viewmodel, _) => Container(
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
                                icon: Icon(Icons.arrow_back,
                                    color: Colors.white)),
                          ))),
                  Form(
                      key: null,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Register Now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Username",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                // controller: ,
                                decoration: textFieldDecoration(),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your user name';
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  // setState(() {
                                  //   username = value;
                                  // });
                                },
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
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
                                } else if (value.length < 7 ||
                                    value.length > 18) {
                                  return 'The length of the password is between 7 and 18.';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                // setState(() {
                                //   password = value;
                                // });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("User Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Radio(
                                //   value: 'customer',
                                //   groupValue: usertype,
                                //   onChanged: null,
                                // ),
                                Text(
                                  'Customer',
                                  style: TextStyle(fontSize: 15),
                                ),
                                // Radio(
                                //   value: 'restaurant',
                                //   groupValue: usertype,
                                //   onChanged:  null,
                                // ),
                                Text(
                                  'Restaurant',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            ElevatedButton(
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
                                // if (_formKey.currentState.validate()) {
                                //   checkUsername();
                                // }
                              },
                              child: Text('Continue'),
                            ),
                          ],
                        ),
                      ))
                ],
              )))),
    );
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

  // Future checkUsername() async {
  //   final msg = jsonEncode({
  //     "username": username,
  //   });
  //   final result = await http_post("/checkusername", msg);
  //   String status = jsonDecode(result.body);
  //   if (status == "Username does not exist") {
  //     if (usertype == "customer") {
  //       // If the form is valid, display a Snackbar.
  //       Navigator.of(context).push(
  //           MaterialPageRoute(builder: (context) => new CusRegistrationForm()));
  //     } else if (usertype == "restaurant") {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => new RestRegistrationForm()));
  //     }
  //   } else {
  //     Future(() {
  //       showDialog<void>(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (BuildContext context) => new AlertDialog(
  //                 title: Text("Username exists!"),
  //                 content: Text("Please try to type a different username."),
  //                 actions: <Widget>[
  //                   TextButton(
  //                       child: Text('Continue'),
  //                       onPressed: () => Navigator.of(context).pop()),
  //                 ],
  //               ));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    // return Form(
    //     key: _formKey,
    //     child: Container(
    //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Column(children: <Widget>[
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: Text("Register Now",
    //                   style:
    //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: Text("Username",
    //                   style:
    //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             TextFormField(
    //               decoration: textFieldDecoration(),
    //               validator: (value) {
    //                 if (value.isEmpty) {
    //                   return 'Please enter your user name';
    //                 }
    //                 return null;
    //               },
    //               onChanged: (String value) {
    //                 setState(() {
    //                   username = value;
    //                 });
    //               },
    //             ),
    //           ]),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text("Password",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           TextFormField(
    //             obscureText: true,
    //             decoration: textFieldDecoration(),
    //             validator: (value) {
    //               if (value.isEmpty) {
    //                 return 'Please enter your password';
    //               } else if (value.length < 7 || value.length > 18) {
    //                 return 'The length of the password is between 7 and 18.';
    //               }
    //               return null;
    //             },
    //             onChanged: (String value) {
    //               setState(() {
    //                 password = value;
    //               });
    //             },
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text("User Type",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Radio(
    //                 value: 'customer',
    //                 groupValue: usertype,
    //                 onChanged: (String value) {
    //                   setState(() {
    //                     usertype = value;
    //                   });
    //                 },
    //               ),
    //               Text(
    //                 'Customer',
    //                 style: TextStyle(fontSize: 15),
    //               ),
    //               Radio(
    //                 value: 'restaurant',
    //                 groupValue: usertype,
    //                 onChanged: (String value) {
    //                   setState(() {
    //                     usertype = value;
    //                   });
    //                 },
    //               ),
    //               Text(
    //                 'Restaurant',
    //                 style: TextStyle(fontSize: 15),
    //               ),
    //             ],
    //           ),
    //           ElevatedButton(
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
    //                 (Set<MaterialState> states) {
    //                   if (states.contains(MaterialState.pressed))
    //                     return Colors.orange.withOpacity(0.5);
    //                   return Colors.orange; // Use the component's default.
    //                 },
    //               ),
    //             ),
    //             onPressed: () {
    //               if (_formKey.currentState.validate()) {
    //                 checkUsername();
    //               }
    //             },
    //             child: Text('Continue'),
    //           ),
    //         ],
    //       ),
    //     ));
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
