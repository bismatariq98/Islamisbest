import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:islamisbest/layers/data_layer/data_providers/contants.dart';
import 'package:islamisbest/layers/data_layer/models/user_model.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/subscription.dart';
import 'chat_room.dart';

class ScholarMainScreen extends StatefulWidget {
  static double heightStep, widthStep;
  final userId;
  ScholarMainScreen(this.userId);

  @override
  _ScholarMainScreenState createState() => _ScholarMainScreenState();
}

class _ScholarMainScreenState extends State<ScholarMainScreen> {
  String searchText = "";
  Icon searchIcon = Icon(Icons.search);
  bool isSearched = false;
  Widget textFields() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }

  Widget _buildMyAppBar(context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: ScholarMainScreen.widthStep * 10,
          labelStyle: TextStyle(
            fontSize: ScholarMainScreen.widthStep * 50,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: ScholarMainScreen.widthStep * 40,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.black,
          tabs: [
            Text("Chats"),
            Text("Scholars"),
          ],
        ),
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
        title: !isSearched
            ? Text("Chat with Scholars", style: TextStyle(color: Colors.white))
            : textFields());
  }

  Widget _buildSingleMenChat({
    context,
    String name,
    String image,
  }) {
    return Container(
      height: ScholarMainScreen.heightStep * 100,
      width: double.infinity,
      color: Colors.white24,
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: ScholarMainScreen.heightStep * 35,
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

  Widget _buildSingleMessage({
    context,
    String name,
    String message,
    String image,
    String messageCount,
    bool isMessageCount,
  }) {
    return GestureDetector(
      onTap: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(
                    "Write your Location",
                    style: TextStyle(fontSize: 24),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "To Start a chat with scholars you will have to purchase a plan",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                return Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => subscription(),
                                  ),
                                );
                              },
                              child: Text(
                                "View Plan",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.green),
                              ),
                            )
                          ],
                        ),
                        // RaisedButton(
                        //   onPressed: () {
                        //     return Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //         builder: (ctx) => subscription(),
                        //       ),
                        //     );
                        //   },
                        //   child: Text("Continue"),
                        // )
                      ],
                    ),
                  ));
            });
      },
      child: Container(
        height: ScholarMainScreen.heightStep * 100,
        width: double.infinity,
        color: Colors.white24,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: ScholarMainScreen.heightStep * 35,
              backgroundImage: AssetImage(
                "images/$image.jpg",
              ),
            ),
            title: Text(
              name,
              style: myTextStyle,
            ),
            subtitle: Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: isMessageCount == false
                ? messageCount == ""
                    ? SizedBox()
                    : Container(
                        child: Text(
                          messageCount,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                : Text(""),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScholarMainScreen.widthStep = MediaQuery.of(context).size.width / 1000;
    ScholarMainScreen.heightStep = MediaQuery.of(context).size.height / 1000;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildMyAppBar(context),
        body: Container(
          height: double.infinity,
          decoration: myDecoration,
          width: double.infinity,
          child: SafeArea(
            child: TabBarView(
              children: [
                Container(
                    height: double.infinity,
                    padding: EdgeInsets.only(
                      top: ScholarMainScreen.heightStep * 20,
                    ),
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        //refine this to users chats
                        stream: db
                            .collection('chatData')
                            .where('UserID', isEqualTo: widget.userId)
                            .orderBy('LastMessageTime', descending: true)
                            .snapshots(),
                        // stream: db.collection('scholars').snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return snapshot.data.docs[index]
                                            .data()['ScholarName']
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchText.toLowerCase())
                                        ? GestureDetector(
                                            onTap: () {
                                              getUserData().then((user) {
                                                return Navigator.of(context)
                                                    .push(
                                                  MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        ChatRoomPage(
                                                      userId: user.userId,
                                                      receiverID: snapshot
                                                          .data.docs[index]
                                                          .data()['ScholarID'],
                                                      chatRoomId: snapshot
                                                          .data.docs[index]
                                                          .data()['ChatID'],
                                                      receiverImage: snapshot
                                                              .data.docs[index]
                                                              .data()[
                                                          'ScholarProfile'],
                                                      receiverName: snapshot
                                                              .data.docs[index]
                                                              .data()[
                                                          'ScholarName'],
                                                    ),
                                                  ),
                                                );
                                              });
                                              //navigate to chat screen with this scholar ID
                                            },
                                            child: Column(
                                              children: [
                                                _buildSingleMessage(
                                                  name: snapshot
                                                      .data.docs[index]
                                                      .data()['ScholarName'],
                                                  messageCount: snapshot.data
                                                                  .docs[index]
                                                                  .data()[
                                                              'SeenbyUser'] ==
                                                          "yes"
                                                      ? ""
                                                      : "New",
                                                  message: snapshot
                                                      .data.docs[index]
                                                      .data()['LastMessage'],
                                                  isMessageCount: false,
                                                  image: "muslammen",
                                                  context: context,
                                                ),
                                                SizedBox(
                                                  height: ScholarMainScreen
                                                          .heightStep *
                                                      15,
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox();
                                  },
                                )
                              : Container();
                        })),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(
                    top: ScholarMainScreen.heightStep * 20,
                  ),
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                      //db.collection('chatdata').snapshots().where ('userid'),is equal to curent user id query lga k he krni h na use rk table sy

                      stream: db.collection('scholars').snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      getUserData().then((user) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => ChatRoomPage(
                                              chatRoomId: "",
                                              //ya thk lkha h ?
                                              receiverName: snapshot
                                                  .data.docs[index]
                                                  .data()['scholarName'],
                                              receiverImage: snapshot
                                                  .data.docs[index]
                                                  .data()['scholarImage'],
                                              userId: user.userId,
                                              receiverID: snapshot
                                                  .data.docs[index]
                                                  .data()['scholarId'],
                                            ),
                                          ),
                                        );
                                      });
                                      //navigate to chat screen with this scholar ID
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
                                          height:
                                              ScholarMainScreen.heightStep * 15,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
