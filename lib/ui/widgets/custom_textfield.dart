import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextInputAction action;
  TextInputType type;
  TextEditingController controller;
  String hintText;

  CustomTextField({
    this.action, this.type,
    this.controller, this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textInputAction: action,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText
        ),
      ),
    );
  }
}