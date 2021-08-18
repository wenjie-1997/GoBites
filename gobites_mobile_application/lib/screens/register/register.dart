import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/register/register_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class Register extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => Register());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RegisterViewmodel>(),
        builder: (context, viewmodel, _) {
          RegisterViewmodel _viewmodel = viewmodel;
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
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.white)),
                              ))),
                      Form(
                          key: _viewmodel.formKeyOne,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
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
                                      _viewmodel.username = value;
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
                                    _viewmodel.password = value;
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
                                    Radio(
                                      value: 'customer',
                                      groupValue: _viewmodel.usertype,
                                      onChanged: (value) =>
                                          _viewmodel.usertype = value,
                                    ),
                                    Text(
                                      'Customer',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Radio(
                                      value: 'restaurant',
                                      groupValue: _viewmodel.usertype,
                                      onChanged: (value) =>
                                          _viewmodel.usertype = value,
                                    ),
                                    Text(
                                      'Restaurant',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Colors.orange.withOpacity(0.5);
                                        return Colors
                                            .orange; // Use the component's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_viewmodel.formKeyOne.currentState
                                            .validate() &&
                                        _viewmodel.usertype != null) {
                                      final bool existed =
                                          await _viewmodel.checkUsername();
                                      if (existed) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'The username is existed. Try another one.'),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        if (_viewmodel.usertype == "customer") {
                                          Navigator.pushNamed(
                                              context, '/register_cust');
                                        } else {
                                          Navigator.pushNamed(
                                              context, '/register_rest');
                                        }
                                      }
                                    }
                                  },
                                  child: Text('Continue'),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ))));
        });
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
