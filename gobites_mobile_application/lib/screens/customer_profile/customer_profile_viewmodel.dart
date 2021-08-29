import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/customer.dart';
import 'package:gobites/services/customer/customer_service.dart';

import '../viewmodel.dart';

class CustProfileViewmodel extends Viewmodel {
  CustomerService get _service => dependency();
  Customer customer;
  final formKeyforEdit = GlobalKey<FormState>();
  TextEditingController usernameController;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController addressController;
  TextEditingController telephoneNoController;
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
}
