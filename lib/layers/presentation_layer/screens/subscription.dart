import 'package:islamisbest/main.dart';
import 'package:flutter/material.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/data_layer/data_providers/contants.dart';
import 'package:get/get.dart';
import 'package:islamisbest/layers/presentation_layer/screens/Choosplan.dart';

class subscription extends StatefulWidget {
  @override
  _subscriptionState createState() => _subscriptionState();
}

class _subscriptionState extends State<subscription> {
  @override
  Widget build(BuildContext context) {
    Widget buildCont({context}) {
      return Container(
        height: 190,
        width: MediaQuery.of(context).size.width,
        color: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  "5.00",
                  style: TextStyle(fontSize: 42, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 25.0),
                  child: Container(
                    height: 55,
                    width: 150,
                    color: Color(0xFF00B823),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Get.to(ChoosePlan());
                        },
                        child: Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Text(
                "For 1 Month",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text(
          "Choose a Plan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: myDecoration,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              buildCont(context: context),
              SizedBox(
                height: 12,
              ),
              buildCont(context: context),
              SizedBox(
                height: 12,
              ),
              buildCont(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
