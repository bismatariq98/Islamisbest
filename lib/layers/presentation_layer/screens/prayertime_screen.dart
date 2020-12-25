// import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:islamisbest/layers/data_layer/models/prayer_timing_model.dart';
import 'package:islamisbest/layers/presentation_layer/constants/media_query.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'dart:convert';

import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';

// import 'package:permission_handler/permission_handler.dart';

class GetPrayerData {}

// ignore: must_be_immutable
class PrayerTimeScreen extends StatefulWidget {
  final country;
  final city;
  PrayerTimeScreen({this.city, this.country});

  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  // Position _currentPosition;
  // String _currentAddress;
  //variables
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String toadyDate = "";

  //functions
  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white24,
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
          icon: Icon(
            Icons.refresh,
            size: 30,
            color: Colors.white,
          ),

          onPressed: () {
            return null;
          },
          //  onPressed: () async {
          //               if (await Permission.locationWhenInUse.isGranted ||
          //                   await Permission.location.isGranted ||
          //                   await Permission.locationAlways.isGranted) {
          //                 _getCurrentLocation();// ks mai ?eo locator pkg
          //               } else {
          //                 await Permission.location.request().then((value) {
          //                   if (value.isGranted) {
          //                     _getCurrentLocation();
          //                   }
          //                 });
          //               }
          //             },
        ),
      ],
      title: Text(
        "Prayer Times",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildPrayerTime({String prayerName, String time}) {
    return Container(
      height: MediaQuerys.heightStep * 70,
      margin: EdgeInsets.symmetric(horizontal: MediaQuerys.widthStep * 20),
      padding: EdgeInsets.symmetric(horizontal: MediaQuerys.widthStep * 20),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayerName,
            style: myTextStyle,
          ),
          Text(
            time,
            style: myTextStyle,
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildTopPart(context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuerys.heightStep * 20,
        ),
        width: double.infinity,
        color: Colors.white24,
        child: Column(
          children: [
            Text(
              "04:20 PM",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuerys.heightStep * 50,
              ),
            ),
            Container(
              height: MediaQuerys.heightStep * 100,
              width: MediaQuerys.widthStep * 800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "November 14,2017",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "25 Safar 1439",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<PrayerTimingModel>> getPrayerTimingsData(
      {String country, String city, String month, String year}) async {
    PrayerTimingModel prayerModel;

    List<PrayerTimingModel> prayerList = [];
    String url =
        // 'http://api.aladhan.com/v1/timingsByCity?city=Karachi&country=Pakistan&method=4';
        'https://api.aladhan.com/v1/calendarByCity?city=$city&country=$country&method=2&month=$month&year=$year';

    print(url);
    http.Response response = await http.get(url, headers: {
      "Accept":
          "Accept: text/html, application/xhtml+xml, application/xml;q=0.9, image/webp, */*;q=0.8"
    });
    final data = jsonDecode(response.body);
    // print(data['data']);
    // final data2 = data['data'];
    // print(data2);
    // print(data['data']['timings']);
    data['data'].forEach((element) {
      print(element['timings']['Fajr']);

      prayerModel = PrayerTimingModel(
        fajar: element['timings']['Fajr'],
        sunrise: element['timings']['Sunrise'],
        dhuhr: element['timings']['Dhuhr'],
        asr: element['timings']['Asr'],
        sunset: element['timings']['Sunset'],
        maghrib: element['timings']['Maghrib'],
        isha: element['timings']['Isha'],
        imsak: element['timings']['Imsak'],
        midnight: element['timings']['Midnight'],
        readableDate: element['date']['readable'],
        day: element['date']['gregorian']['day'],
        hijriDay: element['date']['hijri']['day'],
        hijriMonth: element['date']['hijri']['month']['en'],
        hijriYear: element['date']['hijri']['year'],
      );
      prayerList.add(prayerModel);
    });

    print(prayerList);
    return prayerList;
  }

  Widget _buildAllPrayerTime() {
    // getPrayerTimingsData();

    return FutureBuilder(
        future: getPrayerTimingsData(
          country: widget.country,
          city: widget.city,
          month: now.month.toString(),
          year: now.year.toString(),
        ), //getprayerdata.getPrayerTimingsData(),
        builder: (context, snapshot) {
          //

          if (snapshot.hasData) {
            return Container(
              height: 670,
              width: 600,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                // itemCount: 3,
                itemBuilder: (ctx, index) {
                  return toadyDate == snapshot.data[index].day
                      ? Container(
                          // height: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // height: 50,
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuerys.heightStep * 10,
                                ),
                                width: double.infinity,
                                color: Colors.white24,
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat('KK:mm:a').format(now),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuerys.heightStep * 50,
                                      ),
                                    ),
                                    Container(
                                      height: MediaQuerys.heightStep * 100,
                                      width: MediaQuerys.widthStep * 800,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                now = now.subtract(Duration(
                                                    days:
                                                        1)); //ha acha ya subtract q
                                                toadyDate = DateFormat('dd')
                                                    .format(now);
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${snapshot.data[index].readableDate}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data[index].hijriDay}  ${snapshot.data[index].hijriMonth}  ${snapshot.data[index].hijriYear}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                now =
                                                    now.add(Duration(days: 1));
                                                toadyDate = DateFormat('dd').format(
                                                    now); //hijri mai + kysy ho rha???
                                                // now = DateTime(
                                                //     now.hour,
                                                //     now.minute,
                                                //     now.year,
                                                //     now.month,
                                                //     now.day + 1);
                                                // getPrayerTimingsData();
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // return
                              //  _buildPrayerTime(
                              //   prayerName: snapshot.data[index].prayerName,
                              //   time: "09:30",
                              // );
                              Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Container(
                                  height: 2000,
                                  child: Column(
                                    children: [
                                      _buildPrayerTime(
                                        prayerName: "Al-Fajar",
                                        time: snapshot.data[index].fajar,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Sunrise",
                                        time: snapshot.data[index].sunrise,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Al Zohar",
                                        time: snapshot.data[index].dhuhr,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Asar",
                                        time: snapshot.data[index].asr,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Sunset",
                                        time: snapshot.data[index].sunset,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Al-Maghreeb",
                                        time: snapshot.data[index].maghrib,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Al-Eshaa",
                                        time: snapshot.data[index].isha,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Imsak",
                                        time: snapshot.data[index].imsak,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildPrayerTime(
                                        prayerName: "Midnight",
                                        time: snapshot.data[index].midnight,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox();
                },
              ),
            );
          } else {
            return Text("Loading");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    toadyDate = DateFormat('dd').format(now);
    MediaQuerys().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // _buildTopPart(context),
            _buildAllPrayerTime(),
          ],
        ),
      ),
    );
  }
}
