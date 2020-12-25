import 'package:flutter/material.dart';
import 'package:islamisbest/layers/presentation_layer/constants/textformfield_textstyle.dart';

class MyPasswordTextField extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  MyPasswordTextField({
    @required this.name,
    @required this.controller,
  });
  @override
  _MyPasswordTextFieldState createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  bool isVisibility = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // obscureText: isVisibility,
      style: textFormFieldTextStyle,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number';
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: Text("+"),
        // suffixIcon: IconButton(
        //   icon: Icon(
        //     isVisibility == false ? Icons.visibility_off : Icons.visibility,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       isVisibility = !isVisibility;
        //     });
        //   },
        // ),
        hintText: widget.name,
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintStyle: textFormFieldTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
