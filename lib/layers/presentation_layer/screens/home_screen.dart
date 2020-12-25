import 'package:flutter/material.dart';

import 'package:flutter_share/flutter_share.dart';
import 'package:islamisbest/layers/data_layer/models/user_model.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/aamal_main_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/book_main_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/chat_scholar_main.dart';
import 'package:islamisbest/layers/presentation_layer/screens/dua_main_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/login_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/prayer_calendar.dart';
import 'package:islamisbest/layers/presentation_layer/screens/profile_main.dart';
import 'package:islamisbest/layers/presentation_layer/screens/quran_main_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/scholars_list.dart';
import 'package:islamisbest/layers/presentation_layer/screens/video_main_screen.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/Constants.dart';
import 'package:islamisbest/layers/presentation_layer/widgets/toptitle.dart';
// import 'package:share/share.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'package:url_launcher/url_launcher.dart';

import 'prayertime_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  final TextEditingController _countryName = TextEditingController();
  final TextEditingController _cityname = TextEditingController();
  static double widthStep, heightStep;

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print('Settings');
    } else if (choice == Constants.Subscribe) {
      print('Subscribe');
    } else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }

  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("First"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Second"),
          ),
        ],
      );

  bool loading = true;
  @override
  void initState() {
    super.initState();
    getUserData().then((value) {
      if (value != null)
        setState(() {
          userData = value;
          loading = false;
        });
    });
  }

  void drawerGotoPages({BuildContext context, Widget widget}) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => widget));
  }

  void drawerLogout({BuildContext context, Widget widget}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you Sure you want to Logout ??"),
            content: Padding(
              padding: EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => widget));
                    },
                    child: Text("Yes"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildMyAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: widthStep * 15),
          child: Image(
            height: heightStep * 80,
            width: widthStep * 80,
            image: AssetImage(
              "images/ic_language.png",
            ),
          ),
        ),
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
        )
      ],
    );
  }

  Widget _buildSingleButton({Function onPressed, String image, String name}) {
    return RaisedButton(
      color: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: heightStep * 60,
            image: AssetImage("images/$image.png"),
          ),
          SizedBox(
            height: heightStep * 15,
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSingleDrawerTab({Function onTap, String name, String image}) {
    return ListTile(
      onTap: onTap,
      leading: Image(
        height: heightStep * 80,
        width: widthStep * 80,
        image: AssetImage(
          "images/$image.png",
        ),
      ),
      title: Text(
        name,
        style: myTextStyle,
      ),
    );
  }

  Widget _buildMainPartDrawer(context) {
    print(heightStep);
    return Container(
      child: ListView(
        children: [
          _buildSingleDrawerTab(
            image: "ic_home",
            name: "Home",
            onTap: () => drawerGotoPages(
              context: context,
              widget: ProfileMainScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_qurans",
            name: "Quran",
            onTap: () => drawerGotoPages(
              context: context,
              widget: QuranMainScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_books",
            onTap: () => drawerGotoPages(
              context: context,
              widget: BookMainScreen(),
            ),
            name: "Books",
          ),
          _buildSingleDrawerTab(
            onTap: () {
              getUserId().then((value) {
                drawerGotoPages(
                  context: context,
                  widget: ScholarMainScreen(value),
                );
              });
            },
            image: "ic_chat_scholar",
            name: "Chat Scholar",
          ),
          _buildSingleDrawerTab(
            image: "ic_video",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => VideoMainScreen()));
            },
            name: "Video",
          ),
          _buildSingleDrawerTab(
            image: "ic_scholars",
            onTap: () => drawerGotoPages(
              context: context,
              widget: ScholarList(),
            ),
            name: "Scholars",
          ),
          _buildSingleDrawerTab(
            image: "ic_duas",
            onTap: () => drawerGotoPages(
              context: context,
              widget: DuaMainScreen(),
            ),
            name: "Duas",
          ),
          _buildSingleDrawerTab(
            image: "ic_amaals",
            name: "Aamals",
            onTap: () => drawerGotoPages(
              context: context,
              widget: AammalMainScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_prayertime",
            name: "Prayer Time",
            onTap: () => drawerGotoPages(
              context: context,
              widget: PrayerTimeScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_calender",
            name: "Calendar",
            onTap: () => drawerGotoPages(
              context: context,
              widget: PrayerCalendar(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_feedback",
            onTap: () {},
            name: "Feedback",
          ),
          _buildSingleDrawerTab(
            image: "ic_logout",
            onTap: () => drawerLogout(
              context: context,
              widget: LoginScreen(),
              // widget: LoginScreen(),
            ),
            name: "Log Out",
          ),
        ],
      ),
    );
  }

  Widget _buildMorePartDrawer() {
    return Container(
      child: ListView(
        children: [
          _buildSingleDrawerTab(
            image: "ic_setting",
            name: "Settings",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_rate_us",
            name: "Rating",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_share_app",
            name: "Share",
            onTap: () => share,
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_facebok_menu",
            name: "Like us on Facebook",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_web",
            name: "Visit Website",
            onTap: () => _launchURL('https://www.google.com/'),
          ),
        ],
      ),
    );
  }

  _launchURL(url) async {
/* ------------------- const url = 'https://flutter.dev'; ------------------- */

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildDrawerTabbar() {
    return Container(
      height: 40,
      color: Colors.transparent,
      child: TabBar(
        labelColor: Colors.white,
        indicatorWeight: widthStep * 7,
        labelStyle: TextStyle(
          fontSize: widthStep * 50,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: widthStep * 40,
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: Colors.green,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            text: "Main",
          ),
          Tab(
            text: "More",
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black12, BlendMode.colorBurn),
          image: NetworkImage(userData.userImage == null
              ? 'https://via.placeholder.com/150'
              : userData.userImage),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage(userData.userImage == null
                      ? 'https://via.placeholder.com/150'
                      : userData.userImage),
                ),
                // title: Text(
                //  // userData.userName,
                //   style: myTextStyle,
                // ),
                subtitle: GestureDetector(
                  onTap: () => drawerGotoPages(
                    context: context,
                    widget: ProfileMainScreen(),
                  ),
                  child: Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widthStep * 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildDrawerTabbar(),
        ],
      ),
    );
  }

  Widget _buildDrawer(context) {
    return SafeArea(
      child: Drawer(
        child: DefaultTabController(
          length: 2,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: myDecorationMenu,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildDrawerHeader(context),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        _buildMainPartDrawer(context),
                        _buildMorePartDrawer(),
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

  Widget _buildBottomPart({context}) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: heightStep * 1.6,
        crossAxisSpacing: widthStep * 10,
        mainAxisSpacing: heightStep * 9,
        children: [
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => QuranMainScreen(),
                    ),
                  ),
              image: "ic_qurans",
              name: "Quran"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => BookMainScreen(),
                    ),
                  ),
              image: "ic_books",
              name: "Books"),
          _buildSingleButton(
              onPressed: () {
                return getUserId().then((value) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ScholarMainScreen(value),
                    ),
                  );
                });
              },
              image: "ic_chat_scholar",
              name: "Chat Scholar"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ScholarList(),
                    ),
                  ),
              image: "ic_scholars",
              name: "Scholars"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => VideoMainScreen(),
                    ),
                  ),
              image: "ic_video",
              name: "Video"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => PrayerCalendar(),
                    ),
                  ),
              image: "ic_calender",
              name: "Calendar"),
          _buildSingleButton(
              onPressed: () {
                if (userData.userLocation == "") {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Write your Location"),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    controller: _cityname,

                                    // style: textFormFieldTextStyle,
                                    decoration: InputDecoration(
                                      hintText: "City",
                                      fillColor: Colors.white24,
                                      filled: true,
                                      // prefixIcon: Icon(
                                      //  Icon(Icons.)
                                      //   color: Colors.white,
                                      // ),

                                      // labelStyle:Colors.deepOrange
                                      // hintStyle: textFormFieldTextStyle,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _countryName,

                                    // style: textFormFieldTextStyle,
                                    decoration: InputDecoration(
                                      hintText: "Country",
                                      fillColor: Colors.white24,
                                      filled: true,
                                      // prefixIcon: Icon(
                                      //  Icon(Icons.)
                                      //   color: Colors.white,
                                      // ),

                                      // labelStyle:Colors.deepOrange
                                      // hintStyle: textFormFieldTextStyle,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      return Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => PrayerTimeScreen(
                                            country: _countryName.text,
                                            city: _cityname.text,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text("Continue"),
                                  )
                                ],
                              ),
                            ));
                      });
                } else {}
              },
              image: "ic_prayertime",
              name: "PrayerTime"),
          _buildSingleButton(
              onPressed: () => drawerGotoPages(
                    context: context,
                    widget: DuaMainScreen(),
                  ),
              image: "ic_amaals",
              name: "Duas"),
          _buildSingleButton(
              onPressed: () => drawerGotoPages(
                    context: context,
                    widget: AammalMainScreen(),
                  ),
              image: "ic_duas",
              name: "Aamals"),
        ],
        crossAxisCount: 3,
      ),
    );
  }

  Widget _buildMainBody(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: myDecoration,
      padding: EdgeInsets.symmetric(
        horizontal: widthStep * 20,
      ),
      child: Column(
        children: [
          TopTitle(
            onlyTopText: true,
            heightStep: heightStep,
            widthStep: widthStep,
          ),
          _buildBottomPart(context: context),
        ],
      ),
    );
  }

  bool isUserDrawer = false;
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    getFontSize(getTextFontSize: widthStep * 50);
    return //loading?Center(child: CircularProgressIndicator(),):
        Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(),
      drawer: _buildDrawer(context),
      body: _buildMainBody(context),
    );
  }
}
