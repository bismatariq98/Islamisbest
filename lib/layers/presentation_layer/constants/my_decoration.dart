import 'package:flutter/material.dart';

BoxDecoration myDecoration = BoxDecoration(
  // boxShadow: [
  //   BoxShadow(
  //     color: Colors.grey.withOpacity(0.5),
  //     spreadRadius: 5,
  //     blurRadius: 7,
  //     offset: Offset(0, 3),
  //   ),
  // ],
  image: DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage(
      "images/bg1.png",
    ),
  ),
);

BoxDecoration myDecorationMenu = BoxDecoration(
  image: DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage(
      "images/bg-menu1.png",
    ),
  ),
);
