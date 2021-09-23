import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/customer.dart';
import 'package:gobites/services/customer/customer_service.dart';
import 'package:image_picker/image_picker.dart';

import '../viewmodel.dart';

class CustProfileViewmodel extends Viewmodel {
  CustomerService get _service => dependency();
  Customer customer;
  final formKeyforEdit = GlobalKey<FormState>();
  final formKeyforChangePassword = GlobalKey<FormState>();
  TextEditingController usernameController;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController addressController;
  TextEditingController telephoneNoController;
  TextEditingController currentPasswordController;
  TextEditingController newPasswordController;
  TextEditingController newPasswordReEnterController;
  bool currentPasswordNotMatched = false;
  bool newPasswordNotMatched = false;
  String _gender;
  get gender => _gender;
  set gender(value) {
    _gender = value;
    turnIdle();
  }

  DateTime _birthdate;
  get birthdate => _birthdate;
  set birthdate(value) {
    _birthdate = value;
    turnIdle();
  }

  void init() async {
    turnBusy();
    customer = await _service.getCustomerProfile();
    turnIdle();
  }

  void initForEdit() async {
    usernameController = new TextEditingController(text: customer.username);
    nameController = new TextEditingController(text: customer.custname);
    emailController = new TextEditingController(text: customer.email);
    addressController = new TextEditingController(text: customer.address);
    telephoneNoController =
        new TextEditingController(text: customer.telephoneNo);
    _gender = customer.gender;
    _birthdate = customer.birthdate;
    turnIdle();
  }

  void initForChangePassword() {
    currentPasswordController = new TextEditingController();
    newPasswordController = new TextEditingController();
    newPasswordReEnterController = new TextEditingController();
  }

  Future updateProfile() async {
    customer.custname = nameController.text;
    customer.email = emailController.text;
    customer.address = addressController.text;
    customer.telephoneNo = telephoneNoController.text;
    customer.gender = _gender;
    customer.birthdate = _birthdate;
    await _service.updateProfile(customer);
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
