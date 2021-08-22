import 'package:flutter/material.dart';
import 'package:gobites/services/register/register_service.dart';
import 'package:date_format/date_format.dart';
import '../../app/dependencies.dart';
import '../viewmodel.dart';

class RegisterViewmodel extends Viewmodel {
  RegisterSevice get _service => dependency();
  final formKeyOne = GlobalKey<FormState>();
  final formKeyTwo = GlobalKey<FormState>();
  final formKeyThree = GlobalKey<FormState>();
  String _username;
  String _password;
  String _usertype;
  DateTime _birthdate;
  String _custname;
  String _gender;
  String _email;
  String _address;
  String _telephoneNo;
  String _restaurantname;
  String _ownername;
  String _restaurantstyle;
  bool validateEmail = false;
  bool validatePassword = false;

  get username => _username;
  set username(value) {
    _username = value;
    turnIdle();
  }

  get password => _password;
  set password(value) {
    _password = value;
    turnIdle();
  }

  get usertype => _usertype;
  set usertype(value) {
    _usertype = value;
    turnIdle();
  }

  get birthdate => _birthdate;
  set birthdate(value) {
    _birthdate = value;
    turnIdle();
  }

  get custname => _custname;
  set custname(value) {
    _custname = value;
    turnIdle();
  }

  String get gender => _gender;
  set gender(value) {
    _gender = value;
    turnIdle();
  }

  get email => _email;
  set email(value) {
    _email = value;
    turnIdle();
  }

  get address => _address;
  set address(value) {
    _address = value;
    turnIdle();
  }

  get telephoneNo => _telephoneNo;
  set telephoneNo(value) {
    _telephoneNo = value;
    turnIdle();
  }

  get restaurantname => _restaurantname;
  set restaurantname(value) {
    _restaurantname = value;
    turnIdle();
  }

  get ownername => _ownername;
  set ownername(value) {
    _ownername = value;
    turnIdle();
  }

  get restaurantstyle => _restaurantstyle;
  set restaurantstyle(value) {
    _restaurantstyle = value;
    turnIdle();
  }

  void init() {
    _birthdate = null;
    _custname = null;
    _gender = null;
    _email = null;
    _address = null;
    _telephoneNo = null;
    _restaurantname = null;
    _ownername = null;
    _restaurantstyle = null;
  }

  Future<bool> checkUsername() async {
    final bool existed = await _service.checkUsername(this.username);
    return existed;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _birthdate != null ? _birthdate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != _birthdate) this._birthdate = picked;
    turnIdle();
  }

  Future<void> registerCustomer() async {
    final formattedbirthdate = formatDate(_birthdate, [yyyy, '-', m, '-', dd]);
    final json = {
      "username": _username,
      "password": _password,
      "usertype": _usertype,
      "birthdate": formattedbirthdate,
      "custname": _custname,
      "gender": _gender,
      "email": _email,
      "address": _address,
      "telephoneNo": _telephoneNo
    };
    await _service.register(json);
  }

  Future<void> registerRestaurant() async {
    final json = {
      "username": _username,
      "password": _password,
      "usertype": _usertype,
      "restaurantname": _restaurantname,
      "ownername": _ownername,
      "restaurantstyle": _restaurantstyle,
      "email": _email,
      "address": _address,
      "telephoneNo": _telephoneNo
    };
    await _service.register(json);
  }
}
