// import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:dzemaat/layers/presentation_layer/widgets/LocationScreen';

// class TestPage extends StatefulWidget {
//   @override
//   _TestPageState createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   void showToast(message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.black54,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }

//   String status = "";
//   // Location location = new Location();
//   bool serviceEnabled;
//   // void _getCurrentLocation() async {
//   // GeolocationStatus geolocationStatus =
//   //     await Geolocator().checkGeolocationPermissionStatus();
//   // status = geolocationStatus.toString();

//   // switch (geolocationStatus) {
//   //   case GeolocationStatus.denied:
//   //     showToast("Please On GPS for positioning");
//   //     break;
//   //   case GeolocationStatus.disabled:
//   //     showToast("Please On GPS for positioning");
//   //     break;
//   //   case GeolocationStatus.restricted:
//   //     showToast("Please On GPS for positioning");

//   //     break;
//   //   case GeolocationStatus.unknown:
//   //     showToast("Please On GPS for positioning");
//   //     break;
//   //   case GeolocationStatus.granted:
//   //     location.requestPermission();
//   //     location.requestService();

//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => LocationScreen(),
//   //         ),
//   //       );
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     // getCurrentLocation();
//   }

//   String lat = "";
//   String lut = "";

//   getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       lat = '${position.latitude}';
//       lut = '${position.longitude}';
//     });
//   }

//   // Position _currentPosition;
//   // String _currentAddress;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("location"),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.ac_unit_outlined),
//               onPressed: () async {
//                 LocationPermission permission =
//                     await Geolocator.requestPermission();
//                 print(permission);
//                 // _getCurrentLocation();
//               },
//             )
//           ],
//         ),
//         body: Container(
//             child: Column(
//           children: [
//             Text(lat),
//             Text(lut),
//           ],
//         )));
//   }
// }
