import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/login_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/Chiwi.dart';
import 'layers/presentation_layer/screens/forgot_screen.dart';
import 'layers/presentation_layer/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "/home": (ctx) => HomeScreen(),
        "/login": (ctx) => LoginScreen(),
        "/forgot": (ctx) => ForgotScreen(),
        "/register": (ctx) => RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff19ba19),
        snackBarTheme: SnackBarThemeData(
          actionTextColor: Colors.white,
          backgroundColor: Color(0xff19ba19),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyApps(),
      home: HomeScreen(),
      // home: ChewieDemo(),
      // home: TestPage(),
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return HomeScreen();
      //     }
      //     return HomeScreen();
      //   },
      // ),
    );
  }
}
