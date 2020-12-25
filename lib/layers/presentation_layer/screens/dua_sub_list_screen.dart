import 'package:flutter/material.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';

class DuaSubScreen extends StatefulWidget {
  final String duaText;
  final String duaInfo;
  DuaSubScreen({this.duaInfo, this.duaText});
  @override
  _DuaSubScreenState createState() => _DuaSubScreenState();
}

class _DuaSubScreenState extends State<DuaSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              color: Colors.green,
              child: Text(
                widget.duaText,
                style: myTextStyle,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            // height: heightStep * 650,
            color: Colors.black45,
            child: Column(
              children: [
                Text(
                  widget.duaInfo,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
