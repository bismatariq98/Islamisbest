import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/main.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ChoosePlan extends StatefulWidget {
  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: myDecoration,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 240,
              width: 500,
              color: Colors.white24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Payment Successfull",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hey! your payment has been",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    color: Color(0XFF00B823),
                    child: Center(
                        child: Text("Continue",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
