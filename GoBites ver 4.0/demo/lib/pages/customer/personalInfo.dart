import 'dart:convert';
import 'dart:io';
import 'package:demo/modules/http.dart';
import 'package:demo/pages/customer/updatePassword.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/login.dart' as login;
import '../../modules/custdetail.dart';
import 'package:demo/pages/customer/personalInfoUpdatepage.dart';
import 'package:intl/intl.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:image_picker/image_picker.dart';

import '../login.dart';

CustDetail cust;

Future<CustDetail> fetchCustDetail() async {
  final response = await http_get('/customer/' + login.login_id);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CustDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load album, code = ' + response.statusCode.toString());
  }
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  Future<CustDetail> futureCustDetail;
  PickedFile pickedFile;

  void _choose() async {
    final _picker = ImagePicker();
    pickedFile = await _picker.getImage(source: ImageSource.gallery);
    _upload();
  }

  _upload() async {
    if (pickedFile == null) return;
    final File file = File(pickedFile.path);
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;
    final msg = jsonEncode({
      "CID": cust.CID,
      "image": base64Image,
      "name": fileName,
    });
    final result = await http_post("/image", msg);
    String status = jsonDecode(result.body);
    if (status == "OK") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Upload Image Successful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new PersonalInfoPage()),
                            (route) => false);
                      }),
                ],
              ));
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
  void initState() {
    super.initState();
    futureCustDetail = fetchCustDetail();
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new PersonalInfoUpdatePage(cust: cust)));
                    },
                    child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ))))
    ]);

    return Scaffold(
        // IconButton(
        //       icon: Icon(
        //         Icons.edit,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) =>
        //                     new PersonalInfoUpdatePage(cust: cust)));
        //       })
        body: Center(
            child: SingleChildScrollView(
                child: Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: FutureBuilder<CustDetail>(
          future: futureCustDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cust = snapshot.data;
              return Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton.icon(
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
                          backgroundImage: cust.image == null
                              ? AssetImage('assets/default.png')
                              : NetworkImage("http://$DOMAIN/" + cust.image),
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
                                    color: Colors.red,
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.upload_sharp,
                                    ),
                                    color: Colors.white,
                                    onPressed: _choose,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    height: 30.0,
                    color: Colors.red,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Username',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          cust.username,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(children: [
                          Text(
                            '·' * cust.password.length,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            iconSize: 16,
                            splashRadius: 16,
                            icon: Icon(
                              Icons.edit_sharp,
                              size: 16,
                            ),
                            color: Colors.black,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new UpdatePassword(cust: cust))),
                          )
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          cust.custname,
                          style: TextStyle(
                            fontSize: 16.0,
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
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          cust.email,
                          style: TextStyle(
                            fontSize: 16.0,
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
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Gender:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          cust.gender,
                          style: TextStyle(
                            fontSize: 16.0,
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
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Birthday:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          "${DateFormat('dd-MM-yyyy').format(cust.birthdate)}",
                          style: TextStyle(
                            fontSize: 16.0,
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
                    children: [
                      Expanded(
                        flex: 4, // 20%
                        child: Text(
                          'Address:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          cust.address,
                          style: TextStyle(
                            fontSize: 16.0,
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
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    ))));
  }
}
