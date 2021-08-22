import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/register/register_viewmodel.dart';
import 'package:gobites/screens/register/widget/custom_text_field.dart';
import 'package:gobites/screens/view.dart';

class RestRegister extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => RestRegister());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
      viewmodel: dependency<RegisterViewmodel>()..init(),
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
                              icon:
                                  Icon(Icons.arrow_back, color: Colors.white)),
                        ))),
                Form(
                    key: _viewmodel.formKeyThree,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            onChanged: (String value) =>
                                {_viewmodel.restaurantname = value},
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
                            onChanged: (String value) =>
                                {_viewmodel.ownername = value},
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
                            onChanged: (String value) =>
                                {_viewmodel.address = value},
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
                              value: _viewmodel.restaurantstyle,
                              validator: (value) => value == null
                                  ? 'Please select one restaurant style'
                                  : null,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              // decoration: textFieldDecoration(),
                              onChanged: (String newValue) {
                                _viewmodel.restaurantstyle = newValue;
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
                              _viewmodel.telephoneNo = value;
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
                              _viewmodel.email = value;
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
                              onPressed: () async {
                                if (_viewmodel.formKeyThree.currentState
                                    .validate()) {
                                  await _viewmodel.registerRestaurant();
                                  await showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text("Resgister Successful"),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Text('Continue'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop()),
                                            ],
                                          ));
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
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
      },
    );
  }
}
