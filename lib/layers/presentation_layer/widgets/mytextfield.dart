import 'package:flutter/material.dart';
import 'package:islamisbest/layers/presentation_layer/constants/textformfield_textstyle.dart';

class MyTextField extends StatelessWidget {
  final String textName;
  final TextEditingController controller;
  final IconData iconData;
  MyTextField({
    @required this.iconData,
    @required this.controller,
    @required this.textName,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name';
        }
        return null;
      },
      style: textFormFieldTextStyle,
      decoration: InputDecoration(
        hintText: textName,
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(
          iconData,
          color: Colors.white,
        ),

        // labelStyle:Colors.deepOrange
        hintStyle: textFormFieldTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class MyTextFieldOtp extends StatelessWidget {
  final String textName;
  final TextEditingController controller;
  final IconData iconData;
  MyTextFieldOtp({
    @required this.iconData,
    @required this.controller,
    @required this.textName,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Enter Otp';
        }
        return null;
      },
      style: textFormFieldTextStyle,
      decoration: InputDecoration(
        hintText: textName,
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(
          iconData,
          color: Colors.white,
        ),

        // labelStyle:Colors.deepOrange
        hintStyle: textFormFieldTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class MyTextFieldName extends StatelessWidget {
  final String textName;
  final TextEditingController controller;
  final IconData iconData;
  MyTextFieldName({
    @required this.iconData,
    @required this.controller,
    @required this.textName,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textFormFieldTextStyle,
      decoration: InputDecoration(
        hintText: textName,
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(
          iconData,
          color: Colors.white,
        ),

        // labelStyle:Colors.deepOrange
        hintStyle: textFormFieldTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
