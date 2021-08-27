import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/login/login.dart';
import 'package:gobites/screens/view.dart';
import 'customer_profile_viewmodel.dart';
import 'package:intl/intl.dart';


class CustomerProfile extends StatelessWidget {

  final editButton = Row(children: [
    Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 70),
            child: Material(
                elevation: 5.0,
                color: Colors.orange,
                child: MaterialButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                  },
                  child: Text(
                    "Edit Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ))))
  ]);

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustProfileViewmodel>()..init(),
        builder: (context, viewmodel, _) {
          CustProfileViewmodel _viewmodel = viewmodel;
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              new AlertDialog(
                                                content: Text(
                                                    "Are you sure to logout from the system?"),
                                                actions: <Widget>[
                                                  TextButton(
                                                      child: Text('No'),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop()),
                                                  TextButton(
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    new Login()),
                                                            (route) => false);
                                                      })
                                                ],
                                              ));
                                    },
                                    icon: Icon(Icons.logout),
                                    label: Text("Logout"))
                              ]))),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        new CircleAvatar(
                          // backgroundImage: rest.image == null
                          //     ? AssetImage('assets/default.png')
                          //     : NetworkImage("http://$DOMAIN/" + rest.image),
                          radius: 70.0,
                        ),
                        new Positioned(
                            right: 0,
                            bottom: 0,
                            child: new Material(
                              color: Colors.transparent,
                              child: Center(
                                child: Ink(
                                  decoration: const ShapeDecoration(
                                    color: Colors.orange,
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.upload_sharp,
                                    ),
                                    color: Colors.white,
                                    onPressed: null,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Username',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.customer.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                          },
                          child: Row(children: [
                            Text(
                              "Change Password  ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.edit_sharp,
                                size: 16, color: Colors.blue),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.customer.custname,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.customer.email,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Gender',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.customer.gender,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Birthday',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          "${DateFormat('dd-MM-yyyy').format(_viewmodel.customer.birthdate)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Address',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.customer.address,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Telephone No.',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.customer.telephoneNo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  editButton,
                ],
              ),
            ),
          );
        });
  }
}
