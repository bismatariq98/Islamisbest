import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mybutton.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mypasswordtextfield.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/mytextfield.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/toptitle.dart';
import 'login_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  static double widthStep, heightStep;
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<String> _locations = ['User', 'Scholar']; // Option 2
  String _selectedLocation; // Option 2
  String currentLeague = "Select Leauge";
  List<String> leaugeList = [
    "User"
        "Scholar",
  ];
  final firestoreInstance = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RegExp regExp = new RegExp(RegisterScreen.p);

  bool isLoading = false;
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _smsController = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  String _message = '';

  String _verificationId;

  bool smsSent = false;

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

      saveUserIntoFireStore();

      scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text("Phone number automatically verified : $phoneAuthCredential"),
      ));
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(
      //       "Phone number automatically verified and user signed in: $phoneAuthCredential"),
      // ));
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
      // firebaseMessaging.getToken().then((value) {
      //   token = value;
      //   firebaseMessaging.subscribeToTopic("notify");
      // });

      firestoreInstance
          .collection('users')
          .doc(user.uid)
          .set({
            'userId': user.uid,
            'userPhone': user.phoneNumber,
            'userName': _nameController.text,
            'location': "",
            'subscriptionStatus': "checking",
            'userStatus': "",
            'image': "",
          })
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen())))
          .catchError(
            (error) => print("Failed to add user: $error"),
          );
    });
    return null;
  }
  // void submit() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  // userAuthenticationService
  //     .registerWithEmailAndPassword(email.text, password.text)
  //     .then((user) {
  //   if (user == null) return;
  //   FirebaseFirestore.instance.collection('users').doc(user.uid).set(
  //     {
  //       'userName': userName.text,
  //       'userId': user.uid,
  //       'email': email.text,
  //       'userStatus': 'notScholar',
  //       'subscriptionStatus': 'checking',
  //       'image':
  //           "https://www.seekpng.com/png/detail/115-1150053_avatar-png-transparent-png-royalty-free-default-user.png",
  //     },
  //   );
  //   setState(() {
  //     isLoading = false;
  //   });
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  // });
  // } on PlatformException catch (error) {
  // String message = 'Please Check Your Internet Connection ';
  // if (error.message != null) {
  //   message = error.message;
  // }
  // print(message);
  // // scaffoldKey.currentState.showSnackBar(SnackBar(
  // //   content: Text(message.toString()),
  // //   duration: Duration(milliseconds: 600),
  // //   backgroundColor: Theme.of(context).primaryColor,
  // // ));
  //   setState(() {
  //     isLoading = false;
  //   });
  // } catch (error) {
  //   setState(() {
  //     isLoading = false;
  //   });
  // scaffoldKey.currentState.showSnackBar(SnackBar(
  //   content: Text(error.toString()),
  //   duration: Duration(milliseconds: 600),
  //   backgroundColor: Theme.of(context).primaryColor,
  // ));
  //   }
  // }

  void validation() async {
    if (_nameController.text.isEmpty && _phoneNumberController.text.isEmpty) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('All fields are empty'),
        ),
      );
    } else if (_nameController.text.length < 6) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Name must be at least 6 letters'),
        ),
      );
    } else if (_phoneNumberController.text.isEmpty) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Phone Number field is empty'),
        ),
      );
    }
    // else if (!regExp.hasMatch(email.text)) {
    //   // ignore: deprecated_member_use
    //   scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       content: Text("Please try a valid email"),
    //     ),
    //   );
    // }

    // else if (password.text.isEmpty) {
    //   // ignore: deprecated_member_use
    //   scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       content: Text("Password is empty"),
    //     ),
    //   );
    // } else if (password.text.length < 6) {
    //   // ignore: deprecated_member_use
    //   scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       content: Text("Password is too short"),
    //     ),
    //   );
    // } else if (confirmPassword.text.length < 6) {
    //   // ignore: deprecated_member_use
    //   scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       content: Text("Password is too short"),
    //     ),
    //   );
    // } else if (confirmPassword.text != password.text) {
    //   // ignore: deprecated_member_use
    //   scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       content: Text("Password doesn't match, check again"),
    //     ),
    //   );
    // }
    else {
      _verifyPhoneNumber();
    }
  }

  Widget _buildAllTextField() {
    return smsSent
        ? Container(
            // height: LoginScreen.heightStep * 250,
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
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextField(
                  iconData: Icons.person,
                  controller: _nameController,
                  textName: "Username",
                ),
                SizedBox(
                  height: 12.0,
                ),
                MyPasswordTextField(
                  name: "Phone",
                  controller: _phoneNumberController,
                ),
                SizedBox(
                  height: 12.0,
                ),
                DropdownButton(
                  hint: Text(
                    'User or Scholar',
                    style: TextStyle(color: Colors.white),
                  ), // Not necessary for Option 1
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: Container(
                        color: Colors.green,
                        child: new Text(
                          location,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      value: location,
                    );
                  }).toList(),
                ),
                // MyPasswordTextField(
                //   name: "Password",
                //   controller: password,
                // ),
                // SizedBox(
                //   height: 12.0,
                // ),
                // MyPasswordTextField(
                //   name: "Confrim Password",
                //   controller: confirmPassword,
                // ),
                SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          );
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
        content: Text("Successfully signed up : ${user.phoneNumber}"),
      ));
    } catch (e) {
      print(e);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Failed to sign Up"),
      ));
    }
  }

  Widget _buildButtonAndTextPart(BuildContext context) {
    return Column(
      children: [
        smsSent
            ? MyButton(
                containerHeight: RegisterScreen.heightStep * 65,
                buttonName: "Sign In",
                textFontSize: RegisterScreen.widthStep * 45,
                onPressed: () async {
                  _signInWithPhoneNumber();
                })
            : MyButton(
                buttonName: "Sign Up",
                containerHeight: RegisterScreen.heightStep * 65,
                onPressed: () async {
                  if (_selectedLocation == "") {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Please select one of them")));
                  }
                  String number = "+${_phoneNumberController.text}";
                  QuerySnapshot dsnap = await FirebaseFirestore.instance
                      .collection("users")
                      .where("userPhone", isEqualTo: number)
                      .get()
                      .then((e) {
                    if (e.size > 0) {
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Number Already Registered"),
                      ));
                      // _verifyPhoneNumber();
                    } else {
                      setState(() {
                        validation();
                        // _message = "Number is not registered";
                      });
                    }
                  });
                },

                //  validation(),
                textFontSize: RegisterScreen.widthStep * 50,
              ),
        MyButton(
          buttonName: "Sign In",
          color: Colors.black54,
          containerHeight: RegisterScreen.heightStep * 65,
          onPressed: () => Navigator.of(context).pushReplacementNamed("/login"),
          textFontSize: RegisterScreen.widthStep * 50,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    RegisterScreen.widthStep = MediaQuery.of(context).size.width / 1000;
    RegisterScreen.heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: myDecoration,
          height: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: RegisterScreen.widthStep * 30),
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopTitle(
                  heightStep: RegisterScreen.heightStep,
                  screenName: "Register",
                  onlyTopText: false,
                  widthStep: RegisterScreen.widthStep,
                ),
                SizedBox(
                  height: RegisterScreen.heightStep * 40,
                ),
                _buildAllTextField(),
                _buildButtonAndTextPart(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
