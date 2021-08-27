import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/menu.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/menu/menu_service.dart';

class RestaurantMenuViewmodel extends Viewmodel {
  MenuService get _service => dependency();
  List<Menu> menuList;

  final formKeyForAdd = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController descController;
  Menu updatingMenu;

  void init() async {
    turnBusy();
    menuList = await _service.getMenuList();
    turnIdle();
  }

  void initAddMenu() async {
    nameController = new TextEditingController();
    priceController = new TextEditingController();
    descController = new TextEditingController();
  }

  void initEditMenu(Menu menu) async {
    updatingMenu = menu;
    nameController = new TextEditingController(text: menu.name);
    priceController = new TextEditingController(text: menu.price.toString());
    descController = new TextEditingController(text: menu.description);
  }

  Future<void> addMenu() async {
    Menu newMenu = Menu(
        name: nameController.text,
        price: double.parse(priceController.text),
        description: descController.text);
    await _service.addMenu(newMenu.toJson());
    turnBusy();
    menuList = await _service.getMenuList();
    turnIdle();
  }

  Future<void> updateMenu() async {
    updatingMenu.name = nameController.text;
    updatingMenu.price = double.parse(priceController.text);
    updatingMenu.description = descController.text;
    await _service.updateMenu(updatingMenu.toJson());
    turnBusy();
    menuList = await _service.getMenuList();
    turnIdle();
  }

  Future<void> deleteMenu(int mid) async {
    await _service.deleteMenu(mid);
    turnBusy();
    menuList = await _service.getMenuList();
    turnIdle();
  }
}
