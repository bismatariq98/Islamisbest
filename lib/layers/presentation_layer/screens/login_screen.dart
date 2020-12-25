import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:get/get.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mybutton.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mypasswordtextfield.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mytextfield.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/toptitle.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _smsController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();

//   String _message = '';
//   String _verificationId;
//   bool smsSent = false;
//   // String _location = "";
//   // String _address = "";
//   // String _latitude = "";
//   String _longitude = "";

//   final firestoreInstance = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(top: 150.0, bottom: 50.0),
//                   height: 100,
//                   child: Image.asset("images/logo.png"),
//                 ),
//                 Container(
//                   child: const Text('Login or Register to continue',
//                       style: TextStyle(fontSize: 20.0, color: Colors.blueGrey)),
//                   alignment: Alignment.center,
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 smsSent
//                     ? Container(
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 20.0, right: 20.0),
//                               child: TextField(
//                                 controller: _smsController,
//                                 onSubmitted: (_) => _signInWithPhoneNumber(),
//                                 decoration: const InputDecoration(
//                                     labelText: 'Enter OTP',
//                                     contentPadding:
//                                         EdgeInsets.only(bottom: -5)),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.only(top: 16.0),
//                               alignment: Alignment.center,
//                               child: SignInButtonBuilder(
//                                   icon: Icons.phone,
//                                   backgroundColor: Colors.deepOrangeAccent[400],
//                                   onPressed: () async {
//                                     _signInWithPhoneNumber();
//                                   },
//                                   text: 'Sign In'),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Container(
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20, right: 20),
//                               child: TextFormField(
//                                 controller: _nameController,
//                                 decoration: const InputDecoration(
//                                     contentPadding: EdgeInsets.only(bottom: -5),
//                                     labelText: 'Name'),
//                                 validator: (String value) {
//                                   if (value.isEmpty) {
//                                     return 'Name';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20, right: 20),
//                               child: TextFormField(
//                                 onFieldSubmitted: (_) => _verifyPhoneNumber(),
//                                 keyboardType: TextInputType.phone,
//                                 controller: _phoneNumberController,
//                                 decoration: const InputDecoration(
//                                     contentPadding: EdgeInsets.only(bottom: -5),
//                                     prefix: Text("+92"),
//                                     labelText: 'Phone number'),
//                                 validator: (String value) {
//                                   if (value.isEmpty) {
//                                     return 'Phone number';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             Container(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 16.0),
//                               alignment: Alignment.center,
//                               child: SignInButtonBuilder(
//                                 icon: Icons.contact_phone,
//                                 backgroundColor: Colors.deepOrangeAccent[700],
//                                 text: "Verify Number",
//                                 onPressed: () async {
//                                   _verifyPhoneNumber();
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                 Visibility(
//                   visible: _message == null ? false : true,
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text(
//                       _message,
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//       ),
//     );
//   }

//   void _verifyPhoneNumber() async {
//     setState(() {
//       _message = '';
//     });
//     if (_nameController.text == "") {
//       setState(() {
//         _message = "Enter Name";
//       });
//       return;
//     }

//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await _auth.signInWithCredential(phoneAuthCredential);

//       saveUserIntoFireStore();

//       /* */

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//             "Phone number automatically verified and user signed in: $phoneAuthCredential"),
//       ));
//     };

//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       setState(() {
//         smsSent = false;
//         _message = 'Please enter valid phone number';
//       });
//     };

//     PhoneCodeSent codeSent =
//         (String verificationId, [int forceResendingToken]) async {
//       setState(() {
//         smsSent = true;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Please check your phone for the verification code.'),
//       ));
//       _verificationId = verificationId;
//     };

//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       _verificationId = verificationId;
//     };

//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: "+92" + _phoneNumberController.text,
//           timeout: const Duration(seconds: 5),
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       setState(() {
//         smsSent = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Failed to Verify Phone Number: $e"),
//       ));
//     }
//   }

//   // Example code of how to sign in with phone.
//   void _signInWithPhoneNumber() async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _smsController.text,
//       );
//       // ignore: unused_local_variable
//       User users = FirebaseAuth.instance.currentUser;
//       final User user = (await _auth.signInWithCredential(credential)).user;
//       if (User != null) {
//         saveUserIntoFireStore();
//       }

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Successfully signed in : ${user.phoneNumber}"),
//       ));
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Failed to sign in"),
//       ));
//     }
//   }

//   Future<void> saveUserIntoFireStore() {
//     FirebaseAuth.instance.authStateChanges().listen((User user) async {
//       // firebaseMessaging.getToken().then((value) {
//       //   token = value;
//       //   firebaseMessaging.subscribeToTopic("notify");
//       // });

//       firestoreInstance
//           .collection('users')
//           .doc(user.uid)
//           .set({
//             'userId': user.uid,
//             'userPhone': user.phoneNumber,
//             'userName': _nameController.text,
//             'location': "",
//             'subscriptionStatus': "checking",
//             'userStatus': _longitude,
//             'image': "",
//           })
//           .then((value) => Navigator.of(context).push(MaterialPageRoute(
//               builder: (BuildContext context) => HomeScreen())))
//           .catchError(
//             (error) => print("Failed to add user: $error"),
//           );
//     });
//     return null;
//   }
// }

class LoginScreen extends StatefulWidget {
  static double widthStep, heightStep;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _message = '';
  final firestoreInstance = FirebaseFirestore.instance;
  String _verificationId;
  bool smsSent = false;
  bool isLoading = false;
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void submit(context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          duration: Duration(milliseconds: 800),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 800),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  void _signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );
      // ignore: unused_local_variable
      User users = FirebaseAuth.instance.currentUser;
      final User user = (await _auth.signInWithCredential(credential)).user;
      if (User != null) {
        saveUserIntoFireStore();
      }

      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Successfully signed in : ${user.phoneNumber}"),
      ));
    } catch (e) {
      print(e);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Failed to sign in"),
      ));
    }
  }

  // void validation() async {
  //   if (email.text.isEmpty && password.text.isEmpty) {
  //     FirebaseAuth.instance.signOut();
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Both fields Are Empty"),
  //       ),
  //     );
  //   } else if (email.text.isEmpty) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Email Is Empty"),
  //       ),
  //     );
  //   } else if (!regExp.hasMatch(email.text)) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Please Try Valid Email"),
  //       ),
  //     );
  //   } else if (password.text.isEmpty) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Password Is Empty"),
  //       ),
  //     );
  //   } else if (password.text.length < 8) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Password  Is Too Short"),
  //       ),
  //     );
  //   } else {
  //     submit(context);
  //   }
  // }

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    // if (_nameController.text == "") {
    //   setState(() {
    //     _message = "Enter Name";
    //   });
    //   return;
    // }

/* -------------------------------------------------------------------------- */
/*                         this is phone verification                         */
/* -------------------------------------------------------------------------- */

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      // User user = FirebaseAuth.instanceFor().currentUser;

      // saveUserIntoFireStore();

      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            "Phone number automatically verified and user signed in: $phoneAuthCredential"),
      ));
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        smsSent = false;
        _message = 'Please enter valid phone number';
      });
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      setState(() {
        smsSent = true;
      });
      scaffoldKey.currentState.showSnackBar(const SnackBar(
        content: Text('Please check your phone for the verification code.'),
      ));
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+" + _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      setState(() {
        smsSent = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Failed to Verify Phone Number: $e"),
      ));
    }
  }

  Future<void> saveUserIntoFireStore() {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      Get.to(HomeScreen());
    });
    // FirebaseAuth.instance.authStateChanges().listen((User user) async {
    //   // firebaseMessaging.getToken().then((value) {
    //   //   token = value;
    //   //   firebaseMessaging.subscribeToTopic("notify");
    //   // });

    //   firestoreInstance
    //       .collection('users')
    //       .doc(user.uid)
    //       .set({
    //         'userId': user.uid,
    //         'userPhone': user.phoneNumber,
    //         'userName': _nameController.text,
    //         'location': "",
    //         'subscriptionStatus': "checking",
    //         'userStatus': "",
    //         'image': "",
    //       })
    //       .then((value) => Navigator.of(context).push(MaterialPageRoute(
    //           builder: (BuildContext context) => HomeScreen())))
    //       .catchError(
    //         (error) => print("Failed to add user: $error"),
    //       );
    // });
    // return null;
  }

  Widget _buildAllTextField() {
    return smsSent
        ? Container(
            height: LoginScreen.heightStep * 250,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextFieldOtp(
                    iconData: Icons.email,
                    textName: "EnterOtp",
                    controller: _smsController,
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: LoginScreen.heightStep * 250,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MyTextField(
                  //   iconData: Icons.email,
                  //   textName: "Name",
                  //   controller: _nameController,
                  // ),
                  MyPasswordTextField(
                    name: "Phone",
                    controller: _phoneNumberController,
                  ),
                ],
              ),
            ),
          );
  }

  // ignore: unused_element
  Widget _buildBottomText(BuildContext context) {
    return Container(
      height: LoginScreen.heightStep * 40,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed("/forgot"),
            child: Text(
              "Forgot Password?",
              style: myTextStyle,
            ),
          ),
          FlatButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed("/register"),
            child: Text(
              "Register",
              style: myTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildSingleConnectWith({String image, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: LoginScreen.heightStep * 28,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(
          "images/$image.png",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginScreen.widthStep = MediaQuery.of(context).size.width / 1000;
    LoginScreen.heightStep = MediaQuery.of(context).size.height / 1000;
    getFontSize(getTextFontSize: LoginScreen.widthStep * 50);
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: LoginScreen.widthStep * 30),
            height: double.infinity,
            width: double.infinity,
            decoration: myDecoration,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopTitle(
                    onlyTopText: false,
                    heightStep: LoginScreen.heightStep,
                    widthStep: LoginScreen.widthStep,
                    screenName: "SignIn",
                  ),
                  _buildAllTextField(),
                  smsSent
                      ? MyButton(
                          containerHeight: LoginScreen.heightStep * 65,
                          buttonName: "Sign In",
                          textFontSize: LoginScreen.widthStep * 45,
                          onPressed: () async {
                            _signInWithPhoneNumber();
                          })
                      : MyButton(
                          containerHeight: LoginScreen.heightStep * 65,
                          buttonName: "Sign In",
                          textFontSize: LoginScreen.widthStep * 45,
                          onPressed: () async {
                            String number = "+${_phoneNumberController.text}";
                            QuerySnapshot dsnap = await FirebaseFirestore
                                .instance
                                .collection("users")
                                .where("userPhone", isEqualTo: number)
                                .get()
                                .then((e) {
                              if (e.size > 0) {
                                _verifyPhoneNumber();
                              } else {
                                setState(() {
                                  scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text("Number not Registered"),
                                  ));
                                });
                              }
                            });
                          }),
                  Visibility(
                    visible: _message == null ? false : true,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          _message,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  _buildBottomText(context),
                  // Text(
                  //   "Or Continue With",
                  //   style: TextStyle(
                  //     fontSize: LoginScreen.widthStep * 44,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // Container(
                  //   height: LoginScreen.heightStep * 80,
                  //   width: LoginScreen.widthStep * 600,
                  //   child: Center(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         _buildSingleConnectWith(
                  //             image: "phone_img", onTap: () {}),
                  //         _buildSingleConnectWith(image: "facebook"),
                  //         _buildSingleConnectWith(image: "twitter"),
                  //         _buildSingleConnectWith(image: "google"),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () async {
                      QuerySnapshot dnsps = await FirebaseFirestore.instance
                          .collection("users")
                          .where("userPhone",
                              isEqualTo: _phoneNumberController.text)
                          .get()
                          .then((dsnap) {
                        if (dsnap.size > 0) {
                        } else {}
                      });
                    },
                    icon: Icon(Icons.ac_unit),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
