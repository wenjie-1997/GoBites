import 'package:flutter/material.dart';

class CusRegistrationForm extends StatelessWidget {
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

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: birthdate != null ? birthdate : DateTime.now(),
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime.now());
  //   if (picked != null && picked != birthdate)
  //     setState(() {
  //       birthdate = picked;
  //     });
  // }

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
                  key: null,
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
                          // decoration: textFieldDecoration(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your user name';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            // setState(() {
                            //   custname = value;
                            // });
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
                            // Radio(
                            //   value: 'Male',
                            //   groupValue: gender,
                            //   onChanged: (String value) {
                            //     setState(() {
                            //       gender = value;
                            //     });
                            //   },
                            // ),
                            Text(
                              'Male',
                              style: TextStyle(fontSize: 15),
                            ),
                            // Radio(
                            //   value: 'Female',
                            //   groupValue: gender,
                            //   onChanged: (String value) {
                            //     setState(() {
                            //       gender = value;
                            //     });
                            //   },
                            // ),
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
                                  // "${birthdate != null ? birthdate.toLocal().toString().split(' ')[0] : 'Please select the date'}"
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
                                    onPressed: () => null,
                                    // _selectDate(context),
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
                          // decoration: textFieldDecoration(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            // setState(() {
                            //   address = value;
                            // });
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
                          // decoration: textFieldDecoration(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            // setState(() {
                            //   telephoneNo = value;
                            // });
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
                          // decoration: textFieldDecoration(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            // setState(() {
                            //   email = value;
                            // });
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
                              // if (_formKey.currentState.validate()) {
                              //   customerRegister();
                              // }
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
