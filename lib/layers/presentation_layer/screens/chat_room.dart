import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamisbest/layers/data_layer/models/chat_model.dart';
import 'package:islamisbest/layers/data_layer/models/user_model.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/Constants.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/ReusableWidgets.dart';

// ignore: must_be_immutable
class ChatRoomPage extends StatefulWidget {
  String chatRoomId;
  String userId;
  String receiverImage;
  String receiverName;
  String receiverID;
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
  ChatRoomPage(
      {this.chatRoomId,
      this.receiverName,
      this.receiverImage,
      this.receiverID,
      this.userId});
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  //change later
  TextEditingController chatController = TextEditingController();
  CollectionReference chatsPath;

  String readTimeStampDateTime(timestamp) {
    var format = DateFormat('dd MMM yyyy, h:mm a');

    // var date = DateTime.fromMicrosecondsSinceEpoch(timestamp).toDate();
    var date = (timestamp as Timestamp).toDate();
    return format.format(date);
  }

  String readTimeStampDateTimeShort(int timestamp) {
    var format = DateFormat('h:mm a');

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd MMM yyyy, h:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else if (diff.inDays >= 7 && diff.inDays < 30) {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    } else if (diff.inDays >= 30 && diff.inDays < 365) {
      if (diff.inDays == 30) {
        time = (diff.inDays / 30).floor().toString() + ' MONTH AGO';
      } else {
        time = (diff.inDays / 30).floor().toString() + ' MONTHS AGO';
      }
    } else {
      if (diff.inDays == 365) {
        time = (diff.inDays / 365).floor().toString() + ' YEAR AGO';
      } else {
        time = (diff.inDays / 365).floor().toString() + ' YEARS AGO';
      }
    }

    return time;
  }

  bool loading = false;

  // void initializer() {
  //   chatsPath =
  //       db.collection('messages').doc(widget.chatRoomId).collection('chats');
  // }

  @override
  void initState() {
    //
    super.initState();
    // initializer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void backButtonPressed() {}

  // Stream<QuerySnapshot> chatStream() {
  //   return chatsPath
  //       .orderBy('timeEpoch', descending: true)
  //       .limit(50)
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      if (choice == Constants.Settings) {
        print('Settings');
      } else if (choice == Constants.Subscribe) {
        print('Subscribe');
      } else if (choice == Constants.SignOut) {
        print('SignOut');
      }
    }
    // Widget myPopMenu() {
    //   return PopupMenuButton(
    //       onSelected: (value) {
    //         Fluttertoast.showToast(
    //             msg: "You have selected " + value.toString(),
    //             toastLength: Toast.LENGTH_SHORT,
    //             gravity: ToastGravity.BOTTOM,
    //             timeInSecForIosWeb: 1,
    //             backgroundColor: Colors.black,
    //             textColor: Colors.white,
    //             fontSize: 16.0);
    //       },
    //       itemBuilder: (context) => [
    //             PopupMenuItem(
    //                 value: 1,
    //                 child: Row(
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
    //                       child: Icon(Icons.print),
    //                     ),
    //                     Text('Print')
    //                   ],
    //                 )),
    //             PopupMenuItem(
    //                 value: 2,
    //                 child: Row(
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
    //                       child: Icon(Icons.share),
    //                     ),
    //                     Text('Share')
    //                   ],
    //                 )),
    //             PopupMenuItem(
    //                 value: 3,
    //                 child: Row(
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
    //                       child: Icon(Icons.add_circle),
    //                     ),
    //                     Text('Add')
    //                   ],
    //                 )),
    //           ]);
    // }

    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.receiverImage),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.receiverName,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          leading: Container(
            width: 50,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (ctx) => HomeScreen(),
                    //   ),
                    Navigator.pop(context);
                  },
                ),

                // Padding(
                //     padding: EdgeInsets.only(left: 40),
                //     child: CircleAvatar(
                //         backgroundImage: NetworkImage(widget.receiverImage)))
              ],
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: widthStep * 1000,
                  height: heightStep * 1000,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/bg1.png",
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: widthStep * 1000,
                        height: heightStep * 1000,
                      ),
                      // Positioned.fill(
                      //   child: Container(
                      //     // width: widthStep * 1000,
                      //     // height: heightStep * 1000,
                      //     // color: Colors.white,
                      //     decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //       image: AssetImage(
                      //         "images/bg1.png",
                      //       ),
                      //     )),
                      //   ),
                      // ),
                      //Chats
                      Positioned(
                        width: widthStep * 1000,
                        height: heightStep * 850,
                        bottom: heightStep * 100,
                        // width: 1000,
                        // height: 850,
                        // bottom: 40,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              // stream: chatStream(),

/* -------------------------------------------------------------------------- */
/*                                stream query                                */
/* -------------------------------------------------------------------------- */

                              stream: FirebaseFirestore.instance
                                  .collection('messagesData')
                                  .where('ChatID',
                                      isEqualTo:
                                          "${widget.userId}${widget.receiverID}")
                                  .orderBy('MessageTime', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? ListView.builder(
                                        reverse: true,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return snapshot.data.docs.length > 0
                                              ? Row(
                                                  mainAxisAlignment: snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .data()[
                                                              'UserID'] ==
                                                          widget.userId
                                                      ? MainAxisAlignment.end
                                                      : MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 8),
                                                      // EdgeInsets.only(
                                                      //     left: 15,
                                                      //     right: 15),
                                                      child: Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: snapshot
                                                                            .data
                                                                            .docs[
                                                                                index]
                                                                            .data()[
                                                                        'UserID'] ==
                                                                    widget
                                                                        .userId
                                                                ? Colors.black45
                                                                : Color(
                                                                    0xFF00BA20),
                                                          ),
                                                          width: 300,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment: snapshot
                                                                              .data
                                                                              .docs[
                                                                                  index]
                                                                              .data()[
                                                                          'UserID'] ==
                                                                      widget
                                                                          .userId
                                                                  ? CrossAxisAlignment
                                                                      .end
                                                                  : CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 12),
                                                                  child: Text(
                                                                    snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .data()['Message'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                20),
                                                                    child: Text(
                                                                      readTimeStampDateTime(snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .data()['MessageTime']),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  child: Text("empty chat"));
//
                                        },
                                      )
                                    : Container();
                              }),
                        ),
                      ),

                      //Chat field and button
                      Positioned(
                        bottom: 0,
                        child: Material(
                          color: Colors.black45,
                          elevation: 5,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: widthStep * 1000,
                                height: heightStep * 80,
                                color: Colors.black12,
                                child: TextFormField(
                                  controller: chatController,
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  autocorrect: false,
                                  expands: true,
                                  minLines: null,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        // sendChatMessage();
                                      },
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () {
                                        // sendChatMessage();
                                        if (chatController.text != "") {
                                          createRecord();
                                        }
                                      },
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    border: InputBorder.none,
                                    hintText: 'Type something to send...',
                                    hintStyle: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void chatData(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    chatModel.message = snapshot.data.docs[index].data()['message'];
    chatModel.senderId = snapshot.data.docs[index].data()['senderId'];
    chatModel.time =
        readTimeStampDateTime(snapshot.data.docs[index].data()['timeEpoch']);
    chatModel.timeShort = readTimeStampDateTimeShort(
        snapshot.data.docs[index].data()['timeEpoch']);
    chatModel.senderName = snapshot.data.docs[index].data()['senderName'];
    chatModel.senderStatus = snapshot.data.docs[index].data()['senderStatus'];
  }

  void sendChatMessage() {
    chatController.text = chatController.text.trim();
    if (chatController.text.isNotEmpty) {
      chatsPath.add({
        'message': chatController.text,
        'senderName': userData.userName,
        'senderId': userData.userId,
        'timeEpoch': DateTime.now().millisecondsSinceEpoch,
        'senderStatus': userData.userStatus
      });

      chatController.text = '';
    }
  }

  void dismissDeleteReference(
      AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    snapshot.data.docs[index].reference.delete();
  }

  void createRecord() async {
    var databaseReference = FirebaseFirestore.instance;
    String msgTxt = chatController.text;
    chatController.text = "";

    // databaseReference.collection("users").get();

    getUserData().then((user) {
      databaseReference
          .collection("chatData")
          .doc("${user.userId}${widget.receiverID}")
          .set({
        'ChatID': "${user.userId}${widget.receiverID}",
        'ScholarID': widget.receiverID,
        'LastMessage': msgTxt,
        'LastMessageTime': FieldValue.serverTimestamp(),
        'SeenbyScholar': "no",
        'SeenbyUser': "yes",
        'UserID': user.userId,
        'ScholarProfile': widget.receiverImage,
        'UserProfile': user.userId,
        'UserName': user.userName,
        'ScholarName': widget.receiverName
      }).then((value) {
        databaseReference.collection("messagesData").add({
          'Message': '$msgTxt',
          'Sender': 'User',
          'Receiver': 'Scholar',
          'ScholarID': widget.receiverID,
          'ChatID': "${user.userId}${widget.receiverID}",
          'UserID': user.userId,
          'MessageTime': FieldValue.serverTimestamp()
        });
      });
    });
  }
}
