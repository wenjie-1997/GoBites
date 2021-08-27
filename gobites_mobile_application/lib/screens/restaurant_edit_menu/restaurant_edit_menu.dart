import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/menu.dart';
import 'package:gobites/screens/register/widget/custom_text_field.dart';
import 'package:gobites/screens/restaurant_menu/restaurant_menu_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class RestaurantEditMenu extends StatelessWidget {
  static Route route(args) =>
      MaterialPageRoute(builder: (context) => RestaurantEditMenu(args));
  final Menu menu;

  RestaurantEditMenu(this.menu);
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RestaurantMenuViewmodel>()..initEditMenu(menu),
        builder: (context, viewmodel, _) {
          RestaurantMenuViewmodel _viewmodel = viewmodel;
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(children: [
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
                        child: Text("Update Menu",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30))),
                  )
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  key: _viewmodel.formKeyForAdd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Menu name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: _viewmodel.nameController,
                            decoration: textFieldDecoration(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            }),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Price (RM)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _viewmodel.priceController,
                        decoration: textFieldDecoration(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some digit';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _viewmodel.descController,
                        maxLines: 3,
                        decoration: textFieldDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                        ),
                        onPressed: () async {
                          if (_viewmodel.formKeyForAdd.currentState
                              .validate()) {
                            await _viewmodel.updateMenu();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('A menu is updated successfully.'),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ));
        });
  }
}
