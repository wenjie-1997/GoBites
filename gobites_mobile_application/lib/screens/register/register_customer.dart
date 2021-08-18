import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/register/register.dart';
import 'package:gobites/screens/register/register_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class CustRegister extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => CustRegister());
  // Future customerRegister() async {
  //   final formattedbirthdate = formatDate(birthdate, [yyyy, '-', m, '-', dd]);
  //   final msg = jsonEncode({
  //     "username": username,
  //     "password": password,
  //     "usertype": usertype,
  //     "custname": custname,
  //     "birthdate": formattedbirthdate,
  //     "gender": gender,
  //     "address": address,
  //     "email": email,
  //     "telephoneNo": telephoneNo
  //   });
  //   final result = await http_post("/custregister", msg);
  //   String status = jsonDecode(result.body);
  //   showDialog<void>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) => AlertDialog(
  //             title: Text("Resgister Successful"),
  //             actions: <Widget>[
  //               TextButton(
  //                   child: Text('Continue'),
  //                   onPressed: () => Navigator.of(context).pop()),
  //             ],
  //           ));
  //   Navigator.pop(context);
  // }

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
                        key: _viewmodel.formKeyTwo,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Customer Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Customer Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
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
                                  _viewmodel.custname = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Gender",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: _viewmodel.gender,
                                    onChanged: (String value) {
                                      _viewmodel.gender = value;
                                    },
                                  ),
                                  Text(
                                    'Male',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Radio(
                                    value: 'Female',
                                    groupValue: _viewmodel.gender,
                                    onChanged: (String value) {
                                      _viewmodel.gender = value;
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${_viewmodel.birthdate != null ? _viewmodel.birthdate.toLocal().toString().split(' ')[0] : 'Please select the date'}"
                                        "",
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
                                          onPressed: () =>
                                              _viewmodel.selectDate(context),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
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
                                  _viewmodel.address = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Telephone No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
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
                                padding: EdgeInsets.all(20),
                                child: ElevatedButton(
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
                                    if (_viewmodel.formKeyTwo.currentState
                                        .validate()) {
                                      await _viewmodel.registerCustomer();
                                      await showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text(
                                                    "Resgister Successful"),
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
                        ),
                      )
                    ],
                  ))));
        });
  }
}
