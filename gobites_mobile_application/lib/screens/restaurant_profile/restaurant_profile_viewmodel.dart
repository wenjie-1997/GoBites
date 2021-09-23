import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';

import '../viewmodel.dart';

class RestProfileViewmodel extends Viewmodel {
  RestaurantService get _service => dependency();
  Restaurant restaurant;
  final formKeyforEdit = GlobalKey<FormState>();
  final formKeyforChangePassword = GlobalKey<FormState>();
  TextEditingController usernameController;
  TextEditingController restaurantNameController;
  TextEditingController emailController;
  TextEditingController ownerNameController;
  TextEditingController addressController;
  TextEditingController telephoneNoController;
  TextEditingController currentPasswordController;
  TextEditingController newPasswordController;
  TextEditingController newPasswordReEnterController;
  bool currentPasswordNotMatched = false;
  bool newPasswordNotMatched = false;
  String _restaurantstyle;
  get restaurantstyle => _restaurantstyle;
  set restaurantstyle(value) {
    _restaurantstyle = value;
    turnIdle();
  }

  void init() async {
    turnBusy();
    restaurant = await _service.getRestaurantProfile();
    turnIdle();
  }

  void initForEdit() async {
    usernameController = new TextEditingController(text: restaurant.username);
    restaurantNameController =
        new TextEditingController(text: restaurant.restaurantname);
    emailController = new TextEditingController(text: restaurant.email);
    ownerNameController = new TextEditingController(text: restaurant.ownername);
    addressController = new TextEditingController(text: restaurant.address);
    telephoneNoController =
        new TextEditingController(text: restaurant.telephoneNo);
    _restaurantstyle = restaurant.restaurantstyle;
    turnIdle();
  }

  void initForChangePassword() {
    currentPasswordController = new TextEditingController();
    newPasswordController = new TextEditingController();
    newPasswordReEnterController = new TextEditingController();
  }

  Future updateProfile() async {
    restaurant.restaurantname = restaurantNameController.text;
    restaurant.email = emailController.text;
    restaurant.ownername = ownerNameController.text;
    restaurant.address = addressController.text;
    restaurant.telephoneNo = telephoneNoController.text;
    restaurant.restaurantstyle = _restaurantstyle;
    await _service.updateProfile(restaurant);
    init();
  }

  void uploadImage() async {
    final _picker = ImagePicker();
    XFile pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;
    final File file = File(pickedFile.path);
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;
    await _service.uploadImage(fileName, base64Image);

    init();
  }

  Future checkCurrentPassword() async {
    bool result = await _service.checkPassword(currentPasswordController.text);
    currentPasswordNotMatched = !result;
    turnIdle();
  }

  Future updatePassword() async {
    await _service.updatePassword(newPasswordController.text);
  }
}
