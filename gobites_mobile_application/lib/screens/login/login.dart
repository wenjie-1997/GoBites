import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/user.dart';
import 'package:gobites/screens/login/login_viewmodel.dart';
import 'package:gobites/screens/commons/custom_text_field.dart';
import 'package:gobites/screens/view.dart';

class Login extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => Login());

  @override
  Widget build(BuildContext context) {
    final registrationlink = Container(
        child: InkWell(
            child: new Text(
              'New user? Register Now',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue[800],
              ),
            ),
            onTap: () => Navigator.pushNamed(context, "/register")));

    return ConsumerView(
        viewmodel: dependency<LoginViewmodel>(),
        builder: (context, viewmodel, _) {
          LoginViewmodel _viewmodel = viewmodel;
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.yellow[100], Colors.orange[200]])),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('GoBites',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  letterSpacing: 3.0,
                                  color: Colors.black,
                                  fontFamily: 'Vibur')),
                          SizedBox(height: 80.0),
                          customTextField(
                              controller: _viewmodel.usernameController,
                              icon: Icons.person,
                              label: "Username"),
                          SizedBox(height: 20.0),
                          customTextField(
                              controller: _viewmodel.passwordController,
                              icon: Icons.vpn_key,
                              label: "Password",
                              obscured: true),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(children: [
                            Expanded(
                                child: Container(
                                    child: Material(
                                        elevation: 5.0,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.orange,
                                        child: MaterialButton(
                                          padding: EdgeInsets.all(10),
                                          onPressed: () async {
                                            if (_viewmodel.usernameController
                                                    .text.isNotEmpty &&
                                                _viewmodel.passwordController
                                                    .text.isNotEmpty) {
                                              user = await _viewmodel
                                                  .checkCredential();
                                              if (user != null) {
                                                _viewmodel.usernameController
                                                    .text = "";
                                                _viewmodel.passwordController
                                                    .text = "";
                                                user.userType == "customer"
                                                    ? Navigator.popAndPushNamed(
                                                        context, '/cust_main')
                                                    : Navigator.popAndPushNamed(
                                                        context, '/rest_main');
                                              } else {
                                                showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  "Invalid username or password, please try again."),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    child: Text(
                                                                        'Continue'),
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop()),
                                                              ],
                                                            ));
                                              }
                                            }
                                          },
                                          child: Text(
                                            "Login",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                letterSpacing: 2.0),
                                          ),
                                        ))))
                          ]),
                          SizedBox(
                            height: 15.0,
                          ),
                          registrationlink,
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
