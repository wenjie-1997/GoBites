import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/restaurant_menu/restaurant_menu_viewmodel.dart';
import 'package:gobites/screens/restaurant_menu/widgets/custom_card.dart';
import 'package:gobites/screens/view.dart';

class RestaurantMenu extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => RestaurantMenu());

  // Future menuDelete(int id) async {
  //   // print( widget.menu.MID.toString());
  //   final msg = jsonEncode({
  //     /*"itemName": itemName,
  //     "itemPrice": itemPrice,
  //     "itemPhoto": "default.png",
  //     "itemDesc": itemDesc,*/
  //     "MID": id,
  //   });
  //   final result = await http_post("/menudelete", msg);
  //   String status = jsonDecode(result.body);
  //   //String status = loginResult.getStatus();
  //   if (status == "Delete Sucessful") {
  //     showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) => AlertDialog(
  //               title: Text("Delete Successful"),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: Text('Continue'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     Navigator.pushReplacement(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (BuildContext context) =>
  //                                 new RestMenuPage()));
  //                   },
  //                 )
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

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RestaurantMenuViewmodel>()..init(),
        builder: (context, viewmodel, _) {
          RestaurantMenuViewmodel _viewmodel = viewmodel;
          return Scaffold(
            body: Column(children: [
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
                        child: Text("My Menu",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30))),
                  )
                ]),
              ),
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 70.0),
                          itemCount: _viewmodel.menuList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return customCard(
                                _viewmodel.menuList[index],
                                () => Navigator.pushNamed(
                                    context, '/rest_edit_menu',
                                    arguments: _viewmodel.menuList[index]), () {
                              deleteMenuAlert(context, () async {
                                await _viewmodel
                                    .deleteMenu(_viewmodel.menuList[index].mid);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('A menu is deleted successfully.'),
                                  duration: Duration(seconds: 3),
                                ));
                              });
                            });
                          }))),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rest_add_menu');
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.orange,
            ),
          );
        });
  }

  deleteMenuAlert(BuildContext context, Function deleteMenu) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: deleteMenu,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Menu"),
      content: Text("Are you sure to delete this item?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
