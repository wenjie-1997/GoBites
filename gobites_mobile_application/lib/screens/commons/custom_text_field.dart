import 'package:flutter/material.dart';

TextField customTextField(
    {TextEditingController controller,
    String label,
    IconData icon,
    bool obscured = false}) {
  return TextField(
    controller: controller,
    obscureText: obscured,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      hintText: label,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      // errorText: _validateEmail ? 'Username Can\'t Be Empty' : null,
    ),
  );
}
