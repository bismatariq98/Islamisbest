import 'package:flutter/material.dart';
import 'package:islamisbest/layers/data_layer/data_providers/get_dua_data.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';

class DuaMainScreen extends StatefulWidget {
  @override
  _DuaMainScreenState createState() => _DuaMainScreenState();
}

class _DuaMainScreenState extends State<DuaMainScreen> {
  double heightStep, widthStep;
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
        "Duas",
        style: myTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GetDuaData getDuaData = GetDuaData();
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
            future: getDuaData.getDuaData(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, i) {
                    return currentIndex == i
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.black12,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                height: 50,
                                width: 500,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    "${snapshot.data[i].duaNumber} .${snapshot.data[i].duaText}",
                                    style: myTextStyle,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                height: heightStep * 650,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data[i].duaInfo}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: heightStep * 100,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_back_ios),
                                          onPressed: () {
                                            setState(() {
                                              if (currentIndex > 0) {
                                                currentIndex--;
                                              } else {
                                                currentIndex =
                                                    snapshot.data.length - 1;
                                              }
                                            });
                                          },
                                          color: Colors.white,
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
                                          icon: Icon(Icons.arrow_forward_ios),
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
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
                  },
                );
              } else {
                return Text("loading");
              }
            },
          ),
        ),
      ),
      appBar: _buildMyAppBar(context),
    );
  }
}
