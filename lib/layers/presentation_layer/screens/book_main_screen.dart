import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:islamisbest/layers/data_layer/data_providers/get_books_data.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_decoration.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:islamisbest/layers/presentation_layer/screens/book_sub_list_screen.dart';
import 'package:islamisbest/layers/presentation_layer/screens/home_screen.dart';

class BookMainScreen extends StatelessWidget {
  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        ),
      ),
      title: Text(
        "Books",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildSingleBookContainer({String bookImage, bookName}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            height: heightStep * 200,
            width: widthStep * 250,
            imageUrl: bookImage,
          ),
          // Image(
          //   height: heightStep * 200,
          //   width: widthStep * 250,
          //   image: AssetImage("as"),
          // ),
          SizedBox(
            height: heightStep * 12,
          ),
          Text(
            bookName,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }

  void goToBookSubListScreen(
      {String image,
      String name,
      String about,
      String link,
      BuildContext context}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => BookSublistScreen(
          name: name,
          image: image,
          about: about,
          link: link,
        ),
      ),
    );
  }

  static double heightStep, widthStep;

  @override
  Widget build(BuildContext context) {
    BooksModels booksModels = BooksModels();
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        padding: EdgeInsets.symmetric(
            horizontal: widthStep * 20, vertical: heightStep * 20),
        child: FutureBuilder(
          future: booksModels.getBooksData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisSpacing: heightStep * 10,
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => goToBookSubListScreen(
                          context: context,
                          image: "meembook.jpg",
                          name: snapshot.data[index].bookName,
                          about: snapshot.data[index].bookDescription,
                          link: snapshot.data[index].bookDownloadLink),
                      child: _buildSingleBookContainer(
                        bookImage: snapshot.data[index].bookImage,
                        bookName: (snapshot.data[index].bookName as String)
                                    .length >
                                40
                            ? '${snapshot.data[index].bookName.substring(0, 10)}...'
                            : snapshot.data[index].bookName,
                      ),
                    );
                  },
                ),
                // child: GridView.count(
                //   mainAxisSpacing: widthStep * 20,
                //   childAspectRatio: 0.8,
                //   crossAxisSpacing: heightStep * 10,
                //   crossAxisCount: 2,
                //   children: [
                //     GestureDetector(
                // onTap: () => goToBookSubListScreen(
                //         context: context,
                //         image: "meembook.jpg",
                //         name: "Meem is for Mercy",
                //         about: "this is book one",

                //       ),
                //       child: _buildSingleBookContainer(
                //         bookImage: "meembook.jpg",
                //         bookName: "Meem is for Mercy",
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () => goToBookSubListScreen(
                //         context: context,
                //         image: "missionbook.jpg",
                //         name: "Misssion Nizamuddin",
                //           about: "this is book two"
                //       ),
                //       child: _buildSingleBookContainer(
                //         bookImage: "missionbook.jpg",
                //         bookName: "Misssion Nizamuddin",

                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () => goToBookSubListScreen(
                //         context: context,
                //         image: "alchemy.png",
                //         name: "The Alchemy of Affinity",
                //           about: "this is book three"

                //       ),
                //       child: _buildSingleBookContainer(
                //         bookImage: "alchemy.png",
                //         bookName: "The Alchemy of Affinity",

                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () => goToBookSubListScreen(
                //         context: context,
                //         image: "meembook.jpg",
                //         name: "Meem is for Mercy",
                //           about: "this is book four"

                //       ),
                //       child: _buildSingleBookContainer(
                //         bookImage: "meembook.jpg",
                //         bookName: "Meem is for Mercy",
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () => goToBookSubListScreen(
                //         context: context,
                //         image: "missionbook.jpg",
                //         name: "Misssion Nizamuddin",
                //           about: "this is book five"
                //       ),
                //       child: _buildSingleBookContainer(
                //         bookImage: "missionbook.jpg",
                //         bookName: "Misssion Nizamuddin",
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () => goToBookSubListScreen(
                //         context: context,
                //         image: "alchemy.png",
                //         name: "The Alchemy of Affinity",
                //           about: "this is book six"
                //       ),
                //       child: _buildSingleBookContainer(
                //         bookImage: "alchemy.png",
                //         bookName: "The Alchemy of Affinity",
                //       ),
                //     ),
                //   ],
                // ),
              );
            } else {
              return Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}
