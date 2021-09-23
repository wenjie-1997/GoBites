import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/customer_profile/customer_profile_viewmodel.dart';
import 'package:gobites/screens/register/widget/custom_text_field.dart';
import 'package:gobites/screens/view.dart';

class CustomerChangePassword extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => CustomerChangePassword());
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustProfileViewmodel>()..initForChangePassword(),
        builder: (context, viewmodel, _) {
          CustProfileViewmodel _viewmodel = viewmodel;
          return Scaffold(
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
                key: _viewmodel.formKeyforChangePassword,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Reset Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Current Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _viewmodel.currentPasswordController,
                        obscureText: true,
                        decoration: textFieldDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (_viewmodel.currentPasswordNotMatched) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("New Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _viewmodel.newPasswordController,
                        obscureText: true,
                        decoration: textFieldDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the password';
                          } else if (value.length < 8 || value.length > 20) {
                            return 'The length of the password must be from 8 to 15.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Re-enter New Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _viewmodel.newPasswordReEnterController,
                        obscureText: true,
                        decoration: textFieldDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (_viewmodel.newPasswordController.text !=
                              _viewmodel.newPasswordReEnterController.text) {
                            return 'The password does not match with the one you have entered';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.yellow[800].withOpacity(0.5);
                                return Colors.yellow[
                                    800]; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () async {
                            _viewmodel.currentPasswordNotMatched = false;
                            _viewmodel.turnIdle();
                            if (_viewmodel.formKeyforChangePassword.currentState
                                .validate()) {
                              if (!_viewmodel.newPasswordNotMatched) {
                                await _viewmodel.checkCurrentPassword();
                                if (!_viewmodel.currentPasswordNotMatched) {
                                  await _viewmodel.updatePassword();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Your password has been updated')));
                                } else
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'You have typed in a wrong current password. Please try again.')));
                              }
                            }
                          },
                          child: Text('Update'),
                        ),
                      ),
                    ],
                  ),
                ))
          ])));
        });
  }
}
