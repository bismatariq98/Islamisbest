import 'package:flutter/material.dart';
import 'package:islamisbest/layers/data_layer/data_providers/get_video_data.dart';
import 'package:islamisbest/layers/presentation_layer/constants/media_query.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'home_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/Chiwi.dart';

class VideoMainScreen extends StatefulWidget {
  @override
  _VideoMainScreenState createState() => _VideoMainScreenState();
}

class _VideoMainScreenState extends State<VideoMainScreen> {
  VideoPlayerController
      _videoPlayerController1; //2 q shyd aik agy pecy or dsra play adn pause
  // VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  VideoEditing videoEditing = VideoEditing();
  Icon searchIcon = Icon(Icons.search);
  Widget searchBar = Text("AppBar");
  bool isSearching = false;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // this.initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

/* -------------------------------------------------------------------------- */
/*                         controller for video player                        */
/* -------------------------------------------------------------------------- */
  Future<void> initializePlayer(String url) async {
    _videoPlayerController1 = VideoPlayerController.network(url);
    await _videoPlayerController1.initialize();
    // _videoPlayerController2 = VideoPlayerController.network(
    //     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    // await _videoPlayerController2.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }
/* -------------------------------------------------------------------------- */

  Widget _buildMyAppBar(context) {
    return AppBar(
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: MediaQuerys.widthStep * 10,
          labelStyle: TextStyle(
            fontSize: MediaQuerys.widthStep * 50,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: MediaQuerys.widthStep * 40,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            Text("Movies"),
            Text("Shot Clips"),
          ],
        ),
        backgroundColor: Colors.transparent,
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
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
        ],
        title: !isSearching
            ? Text(
                "Video",
                style: myTextStyle,
              )
            : TextFormField(
                decoration: InputDecoration(hintText: "Hello"),
              ));
  }

/* -------------------------------------------------------------------------- */
/*                               video container                              */
/* -------------------------------------------------------------------------- */

  Widget _buildSingleVideo(
      {context, String time, String image, String name, String link}) {
    // _controller = VideoPlayerController.network(image);
    return Stack(
      children: [
        Container(
          height: MediaQuerys.heightStep * 400,
          width: double.infinity,
          color: Colors.white30,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: _chewieController != null &&
                          _chewieController
                              .videoPlayerController.value.initialized
                      ? Chewie(
                          controller: _chewieController,
                        )
                      : Text("Loading")
                  // VideoPlayer(_controller),
                  ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuerys.widthStep * 20,
                    vertical: MediaQuerys.heightStep * 20,
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name == null ? "loading" : name,
                            style: myTextStyle,
                          ),
                          Text(
                            time == null ? "loading" : time,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuerys.heightStep * 50,
          right: MediaQuerys.widthStep * 15,
          child: CircleAvatar(
              maxRadius: MediaQuerys.heightStep * 40,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: () {
                  //
                  initializePlayer(link);
                },
                icon: Icon(
                  Icons.play_arrow,
                  size: MediaQuerys.heightStep * 40,
                  color: Colors.white,
                ),
              )),
        ),
      ],
    );
  }

/* -------------------------------------------------------------------------- */
/*                                  movie tab                                 */
/* -------------------------------------------------------------------------- */

  Widget _buildMovieTab({context, List data}) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              for (var itemData in data)
                itemData.videoType == "Movie"
                    ? _buildSingleVideo(
                        context: context,
                        image: itemData.videoLink,
                        link: itemData.videoLink,
                        time: itemData.videoDuration,
                        name: itemData.videoName)
                    : SizedBox(),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
              // _buildSingleVideo(
              //   context: context,
              //   image: 'https://www.youtube.com/watch?v=Nm_DbC9aYBU',
              //   time: "5:13 Min",
              // ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShotClip(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildSingleVideo(
                context: context,
                image: 'qwe',
                time: "5:13 Min",
              ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
              _buildSingleVideo(
                context: context,
                image: 'qwe',
                time: "05:13 Hrs",
              ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQuerys().init(context);
    return FutureBuilder(
      future: videoEditing.getVideo(),
      builder: (context, snapshot) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: myDecoration,
              child: SafeArea(
                child: TabBarView(
                  children: [
                    _buildMovieTab(
                      context: context,
                      data: snapshot.data,
                    ),
                    _buildShotClip(context),
                  ],
                ),
              ),
            ),
            appBar: _buildMyAppBar(context),
          ),
        );
      },
    );
  }
}
