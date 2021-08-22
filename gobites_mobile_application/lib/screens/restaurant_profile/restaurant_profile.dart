import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/login/login.dart';
import 'package:gobites/screens/restaurant_profile/restaurant_profile_viewmodel.dart';
import 'package:gobites/screens/view.dart';

// Future<RestDetail> fetchRestDetail() async {
//   final response = await http_get('/restaurant/' + login.login_id);

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return RestDetail.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception(
//         'Failed to load detail, code = ' + response.statusCode.toString());
//   }
// }

class RestaurantProfile extends StatelessWidget {
  // Future<RestDetail> futureRestDetail;
  // PickedFile pickedFile;

  // void _choose() async {
  //   final _picker = ImagePicker();
  //   pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   _upload();
  // }

  // _upload() async {
  //   if (pickedFile == null) return;
  //   final File file = File(pickedFile.path);
  //   String base64Image = base64Encode(file.readAsBytesSync());
  //   String fileName = file.path.split("/").last;
  //   final msg = jsonEncode({
  //     "RID": rest.RID,
  //     "image": base64Image,
  //     "name": fileName,
  //   });
  //   final result = await http_post("/restimage", msg);
  //   String status = jsonDecode(result.body);
  //   if (status == "OK") {
  //     showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) => AlertDialog(
  //               title: Text("Upload Image Successful"),
  //               actions: <Widget>[
  //                 TextButton(
  //                     child: Text('Continue'),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                       Navigator.pushReplacement(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) =>
  //                                   new RestaurantPersonalInfoPage()));
  //                     }),
  //               ],
  //             ));
  //   } else {
  //     // AlertDialog(
  //     //   title: Text(status),
  //     //   actions: <Widget>[
  //     //     TextButton(
  //     //       child: Text('Continue'),
  //     //       onPressed: () {
  //     //         Navigator.of(context).pop();
  //     //       },
  //     //     ),
  //     //   ],
  //     // );
  //   }
  // }

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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             new RestInfoUpdatePage(rest: rest)));
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
        viewmodel: dependency<RestProfileViewmodel>()..init(),
        builder: (context, viewmodel, _) {
          RestProfileViewmodel _viewmodel = viewmodel;
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
                          _viewmodel.restaurant.username,
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
                            //  Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             new RestUpdatePassword(rest: rest))),
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
                          'Restaurant Name',
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
                          _viewmodel.restaurant.restaurantname,
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
                          _viewmodel.restaurant.email,
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
                          'Restaurant Owner Name',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Expanded(
                        flex: 6,
                        child: Text(
                          _viewmodel.restaurant.ownername,
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
                          'Restaurant Type/Style',
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
                          _viewmodel.restaurant.restaurantstyle,
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
                          _viewmodel.restaurant.address,
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
                          _viewmodel.restaurant.telephoneNo,
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
