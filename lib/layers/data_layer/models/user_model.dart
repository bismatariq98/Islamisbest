import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamisbest/layers/data_layer/data_providers/contants.dart';

class UserData {
  String userName;
  String userLocation;
  String userId;
  String userPhone;
  String userImage;
  String userStatus; //scholar or user
  String subscriptionStatus;

  UserData({
    this.userPhone,
    this.userLocation,
    this.userId,
    this.userName,
    this.userImage,
    this.userStatus,
    this.subscriptionStatus,
  });
}

UserData userData = UserData();

Future<UserData> getUserData() async {
  final userValue = await db
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();
  //aik br dbara login krvana prna h
  UserData userData = UserData(
    userPhone: userValue.data()['userPhone'],
    userId: userValue.data()['userId'],
    userStatus: userValue.data()['userStatus'],
    userName: userValue.data()['userName'],
    userLocation: userValue.data()['location'],
    userImage: userValue.data()['userImage'],
    subscriptionStatus: userValue.data()['subscriptionStatus'],
  );
  return userData;
}

Future getUserId() async {
  final userValue = await db
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();

  return userValue.data()['userId'];
}
