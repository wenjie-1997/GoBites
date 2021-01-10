import 'dart:convert';
import 'dart:io';
import 'package:demo/modules/http.dart';
import 'package:demo/pages/restaurant/restHomepage.dart';
import 'package:demo/pages/restaurant/updatePassword.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/restdetail.dart';
import 'package:image_picker/image_picker.dart';
import 'restInfoUpdatepage.dart';

RestDetail rest;

Future<RestDetail> fetchRestDetail() async {
  print("Im here");
  final response = await http_get('/restaurant/' + login.login_id);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return RestDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load detail, code = ' + response.statusCode.toString());
  }
}

class RestaurantPersonalInfoPage extends StatefulWidget {
  @override
  _RestaurantPersonalInfoPageState createState() =>
      _RestaurantPersonalInfoPageState();
}

class _RestaurantPersonalInfoPageState
    extends State<RestaurantPersonalInfoPage> {
  Future<RestDetail> futureRestDetail;
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
      "RID": rest.RID,
      "image": base64Image,
      "name": fileName,
    });
    final result = await http_post("/restimage", msg);
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    new RestaurantPersonalInfoPage()));
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
    futureRestDetail = fetchRestDetail();
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
                  builder: (BuildContext context) => new RestHomePage()),
              (route) => false),
        ),
        title: Text('Restaurant Info'),
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
                          new RestInfoUpdatePage(rest: rest)));
            },
          ),
        ],
      ),
      body: FutureBuilder<RestDetail>(
          future: futureRestDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              rest = snapshot.data;
              return Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundImage: rest.image == null
                                ? AssetImage('assets/default.png')
                                : NetworkImage("http://$DOMAIN/" + rest.image),
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
                      rest.username,
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
                        '·' * rest.password.length,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_sharp),
                        color: Colors.black,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new RestUpdatePassword(rest: rest))),
                      )
                    ]),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Restaurant Name:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.restaurantname,
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
                      snapshot.data.email,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Restaurant Owner Name:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.ownername,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Restaurant Type/Style:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.restaurantstyle,
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
                      snapshot.data.address,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.yellow[100],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Restaurant Info'),
        ],
        currentIndex: 1,
      ),
    );
  }
}
