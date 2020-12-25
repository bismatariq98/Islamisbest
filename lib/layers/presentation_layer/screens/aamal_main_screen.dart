import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:islamisbest/layers/data_layer/data_providers/get_aamal_data.dart';
import 'package:islamisbest/layers/data_layer/models/aamal_model.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';

// ignore: must_be_immutable
class AammalMainScreen extends StatefulWidget {
  // AamalModel aamalModel;

  @override
  _AammalMainScreenState createState() => _AammalMainScreenState();
}

class _AammalMainScreenState extends State<AammalMainScreen> {
  GetAamalData getAamalData = GetAamalData();

  List<AamalModel> amal = [];

  int currentIndex = 0;

  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
            ),
          );
        },
      ),
      title: Text(
        "Aammals",
        style: myTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightStep, widthStep;
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        child: SafeArea(
          child: FutureBuilder(
            future: getAamalData.getAamalData(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, i) {
                    return currentIndex == i
                        ? Container(
                            height: Get.height * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  color: Colors.black12,
                                  width: 500,
                                  height: 40,
                                  child: Text(
                                    "${snapshot.data[i].aamalNumber}. ${snapshot.data[i].aamalText}",
                                    style: myTextStyle,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    height: heightStep * 650,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${snapshot.data[i].aamalInfo}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: heightStep * 100,
                                  // width: widthStep * 800,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (currentIndex > 0) {
                                                  currentIndex--;
                                                } else {
                                                  currentIndex =
                                                      snapshot.data.length -
                                                          1; //0 > 0
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${i + 1} /${snapshot.data.length}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (currentIndex <
                                                    snapshot.data.length - 1) {
                                                  currentIndex++;
                                                } else {
                                                  currentIndex = 0;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox();
                  },
                );
              } else {
                return Text("Loading");
              }
            },
          ),
        ),
      ),
      appBar: _buildMyAppBar(context),
    );
  }
}
