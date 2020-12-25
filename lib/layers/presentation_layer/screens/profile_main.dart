import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamisbest/layers/data_layer/models/user_model.dart';
import 'package:islamisbest/layers/presentation_layer/constants/media_query.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mybutton.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mytextfield.dart';

class ProfileMainScreen extends StatefulWidget {
  @override
  _ProfileMainScreenState createState() => _ProfileMainScreenState();
}

File pickedImage;

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  bool _isLoading = false;
  File pickedImage;
  final picker = ImagePicker();
  // File _image;

  Future<void> _getImageCamera() async {
    final imageFileFromCamera =
        await picker.getImage(source: ImageSource.camera);
    if (imageFileFromCamera != null) {
      pickedImage = File(imageFileFromCamera.path);
    }
  }

  Future<void> _getImageGallery() async {
    _isLoading = true;
    final imageFileFromGallery = await picker
        .getImage(source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      return pickedImage = File(value.path);
    });

    if (imageFileFromGallery != null) {
      pickedImage = File(imageFileFromGallery.path);
    }
  }

  // File pickedImage;

  // PickedFile _image;
  // Future<void> getImage({ImageSource source}) async {
  //   _image = await ImagePicker().getImage(source: source);
  //   if (_image != null) {
  //     setState(() {
  //       pickedImage = File(_image.path);
  //     });
  //   }
  // }

  User user;

  Future<String> _uploadImage({File pickedImage}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/${user.uid}");
    StorageUploadTask uploadTask = storageReference.putFile(pickedImage);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  bool isEdit = false;
  void userDetailUpdate() async {
    setState(() {
      isEdit = true;
    });
    String imageUrl =
        pickedImage != null ? await _uploadImage() : userData.userPhone;

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'userName': userName.text,
      // 'email': phone.text,
      'userImage': imageUrl,
    });

    setState(() {
      isEdit = false;
    });
  }

  RegExp regExp = new RegExp(p);
  final TextEditingController phone = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: () {
                      _getImageCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: () {
                      _getImageGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void vaildation() async {
    if (userName.text.isEmpty) {
      // FirebaseAuth.instance.signOut();
      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Username is Empty"),
        ),
      );
    }
    // else if (userName.text.isEmpty) {
    //   // ignore: deprecated_member_use
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Username Is Empty"),
    //     ),
    //   );
    // }
    // else if (phone.text.isEmpty) {
    //   // ignore: deprecated_member_use
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Phone Is Empty"),
    //     ),
    //   );
    // }
    //  else if (!regExp.hasMatch(email.text)) {
    //   // ignore: deprecated_member_use
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Please Try Vaild Email"),
    //     ),
    //   );
    // }
    // else if (userName.text.isEmpty) {
    //   // ignore: deprecated_member_use
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Username Is Empty"),
    //     ),
    //   );
    // }

    else {
      userDetailUpdate();
    }
  }

  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
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
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        "Back",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildBottomPart() {
    return Expanded(
      child: Container(
        // height: 300,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: MyTextField(
                  iconData: Icons.person,
                  textName: userData.userName,
                  controller: userName,
                ),
              ),
              // SizedBox(
              //   height: MediaQuerys.heightStep * 15,
              // ),
              // MyTextField(
              //   iconData: Icons.phone,
              //   controller: phone,
              //   textName: userData.userPhone,
              // ),
              // Expanded(
              //   child: Container(
              //     height: 20,
              //     // height: MediaQuerys.heightStep * 350,
              //   ),
              // ),
              MyButton(
                buttonName: "Update Profile",
                containerHeight: MediaQuerys.heightStep * 70,
                onPressed: () {
                  vaildation();
                },
                textFontSize: MediaQuerys.widthStep * 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPart() {
    return Container(
      color: Colors.white30,
      width: double.infinity,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuerys.heightStep * 45,
            ),
            Container(
              height: 100,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      // backgroundImage: NetworkImage(
                      //   userData.userImage,
                      // ),
                      maxRadius: MediaQuerys.heightStep * 140,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => myDialogBox(context),
                        child: Container(
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuerys.heightStep * 15,
            ),
            GestureDetector(
              onTap: () => myDialogBox(context),
              child: Text(
                "Change Profile Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuerys.widthStep * 40,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuerys.heightStep * 25,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    MediaQuerys().init(context);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("User").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var myDoc = snapshot.data.docs;
                    myDoc.forEach((checkDocs) {
                      if (checkDocs.data()["UserId"] == user.uid) {
                        userData = UserData(
                          userPhone: checkDocs.data()['userPhone'],
                          userImage: checkDocs.data()['userImage'],
                          userName: checkDocs.data()['userName'],
                        );
                      }
                    });
                    return Container(
                      height: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildTopPart(),
                          _buildBottomPart(),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
