import 'package:flutter/material.dart';

import 'package:socio/constants/colorConstants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.text,
  });
  TextEditingController controller;
  Icon icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorHeight: 22,
        controller: controller,
        cursorColor: courserColorPrimary,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), gapPadding: 5.0),
          prefixIcon: icon,
          prefixIconColor: primaryColor,
          fillColor: inputboxColor,
          filled: true,
          hintText: text,
        ));
  }
}
