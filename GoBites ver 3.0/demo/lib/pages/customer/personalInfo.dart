import 'dart:convert';
import 'dart:io';
import 'package:demo/modules/http.dart';
import 'package:demo/pages/customer/custHomepage.dart';
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
  File file;

  get http => null;

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
    _upload();
  }

  _upload() async {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    final result = await http.post("http://$DOMAIN/image", body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });

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
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new CustHomePage())),
          ),
          title: Text('Personal Info'),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
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
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundImage: cust.image == null
                            ? AssetImage('assets/default.png')
                            : NetworkImage("http://$DOMAIN/" + cust.image),
                        radius: 50.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: _choose,
                          child: Text('Choose Image'),
                        ),
                      ],
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
                    Text(
                      cust.password,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
