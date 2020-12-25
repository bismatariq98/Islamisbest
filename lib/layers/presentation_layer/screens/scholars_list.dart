import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:islamisbest/layers/data_layer/data_providers/contants.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';

class ScholarList extends StatefulWidget {
  static double heightStep, widthStep;

  @override
  _ScholarListState createState() => _ScholarListState();
}

class _ScholarListState extends State<ScholarList> {
  bool isSearched = false;
  String searchText = "";
  Widget appbar() {
    return Text(
      "Scholars",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget textFields() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }

  Icon searchIcon = Icon(Icons.search);

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
        actions: [
          IconButton(
            icon: searchIcon,
            onPressed: () {
              setState(() {
                if (searchIcon.icon == Icons.search) {
                  searchIcon = Icon(Icons.cancel);
                  isSearched = true;
                } else {
                  searchIcon = Icon(Icons.search);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        title: !isSearched ? appbar() : textFields());
  }

  Widget _buildSingleMenChat({
    context,
    String name,
    String image,
  }) {
    return Container(
      height: ScholarList.heightStep * 100,
      width: double.infinity,
      color: Colors.white24,
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: ScholarList.heightStep * 35,
            backgroundImage: AssetImage(
              "images/$image.jpg",
            ),
          ),
          title: Text(
            name,
            style: myTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SearchBar searchBar;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    ScholarList.widthStep = MediaQuery.of(context).size.width / 1000;
    ScholarList.heightStep = MediaQuery.of(context).size.height / 1000;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
            actions: [
              IconButton(
                icon: searchIcon,
                onPressed: () {
                  setState(() {
                    if (searchIcon.icon == Icons.search) {
                      searchIcon = Icon(Icons.cancel);
                      isSearched = true;
                    } else {
                      searchIcon = Icon(Icons.search);
                      isSearched = false;
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
            title: !isSearched ? appbar() : textFields()),
        body: Container(
          height: double.infinity,
          decoration: myDecoration,
          width: double.infinity,
          child: SafeArea(
              child: Container(
            height: double.infinity,
            padding: EdgeInsets.only(
              top: ScholarList.heightStep * 20,
            ),
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('scholars').snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data.docs[index]
                                    .data()['scholarName']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase())
                                ? GestureDetector(
                                    onTap: () {
                                      //navigate to scholar profile

                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (ctx) => ,
                                      //   ),
                                      // );
                                    },
                                    child: Column(
                                      children: [
                                        _buildSingleMenChat(
                                          context: context,
                                          image: 'men',
                                          name: snapshot.data.docs[index]
                                              .data()['scholarName'],
                                        ),
                                        SizedBox(
                                          height: ScholarList.heightStep * 15,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container();
                          },
                        )
                      : Container();
                }),
          )),
        ),
      ),
    );
  }
}
