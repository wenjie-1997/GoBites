import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/register/widget/custom_text_field.dart';
import 'package:gobites/screens/customer_profile/customer_profile_viewmodel.dart';
import 'package:gobites/screens/view.dart';
import 'package:intl/intl.dart';

class CustomerEditProfile extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => CustomerEditProfile());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustProfileViewmodel>()..initForEdit(),
        builder: (context, viewmodel, _) {
          CustProfileViewmodel _viewmodel = viewmodel;
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: Stack(children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.orange,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Edit Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30))),
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: _viewmodel.formKeyforEdit,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Username",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: _viewmodel.usernameController,
                      decoration: textFieldDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _viewmodel.nameController,
                      decoration: textFieldDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
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
                      maxLines: 3,
                      controller: _viewmodel.addressController,
                      decoration: textFieldDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton<String>(
                      value: _viewmodel.gender,
                      underline: Container(
                        height: 2,
                        color: Colors.amber[900],
                      ),
                      onChanged: (String newValue) {
                        _viewmodel.gender = newValue;
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Birthdate",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '${DateFormat('dd-MM-yyyy').format(_viewmodel.birthdate)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: _viewmodel.birthdate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2050));
                          if (picked != null) {
                            _viewmodel.birthdate = picked;
                          }
                        }),
                    SizedBox(
                      height: 10,
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
                      controller: _viewmodel.telephoneNoController,
                      decoration: textFieldDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the telephone no.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
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
                      controller: _viewmodel.emailController,
                      decoration: textFieldDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                        ),
                        onPressed: () async {
                          if (_viewmodel.formKeyforEdit.currentState
                              .validate()) {
                            await _viewmodel.updateProfile();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])));
        });
  }
}
