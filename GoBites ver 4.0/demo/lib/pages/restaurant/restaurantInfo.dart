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
import '../login.dart';

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
                                  new RestInfoUpdatePage(rest: rest)));
                    },
                    child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ))))
    ]);
    return Scaffold(

        /*appBar: AppBar(
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
      ),*/
        body: Center(
            child: SingleChildScrollView(
                child: Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: FutureBuilder<RestDetail>(
          future: futureRestDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              rest = snapshot.data;
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
                          backgroundImage: rest.image == null
                              ? AssetImage('assets/default.png')
                              : NetworkImage("http://$DOMAIN/" + rest.image),
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
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          rest.username,
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
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(children: [
                          Text(
                            '·' * rest.password.length,
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
                                        new RestUpdatePassword(rest: rest))),
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
                          'Restaurant Name',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          snapshot.data.restaurantname,
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
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          snapshot.data.email,
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
                          'Restaurant Owner Name',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          snapshot.data.ownername,
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
                          'Restaurant Type/Style',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          snapshot.data.restaurantstyle,
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
                          'Address',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          snapshot.data.address,
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
                          'Telephone No.',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          snapshot.data.telephoneNo,
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
                    height: 10.0,
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
