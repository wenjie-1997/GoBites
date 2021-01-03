import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:demo/modules/http.dart';
import 'package:demo/pages/customer/custHomepage.dart';
import 'package:demo/pages/customer/updatePassword.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/login.dart' as login;
import '../../modules/custdetail.dart';
import 'package:demo/pages/customer/personalInfoUpdatepage.dart';
import 'package:intl/intl.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:image_picker/image_picker.dart';

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
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new CustHomePage()),
                (route) => false),
          ),
          title: Text('Personal Info'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              new PersonalInfoUpdatePage(cust: cust)));
                })
          ]),
      body: FutureBuilder<CustDetail>(
          future: futureCustDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cust = snapshot.data;
              return Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 10.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundImage: cust.image == null
                                ? AssetImage('assets/default.png')
                                : NetworkImage("http://$DOMAIN/" + cust.image),
                            radius: 100.0,
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
                                        size: 30,
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
                      height: 60.0,
                      color: Colors.red,
                    ),
                    Text(
                      'Username:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      cust.username,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Password:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      Text(
                        '·' * cust.password.length,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_sharp),
                        color: Colors.black,
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new UpdatePassword(cust: cust))),
                      )
                    ]),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Name:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      cust.custname,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Email Address:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      cust.email,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Gender:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      cust.gender,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Birthday:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${DateFormat('dd-MM-yyyy').format(cust.birthdate)}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Address:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      cust.address,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.red,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.yellow[200],
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: 'Personal Info'),
      //   ],
      //   currentIndex: 1,
      // ),
    );
  }
}
