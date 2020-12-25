import 'package:flutter/material.dart';
import 'package:islamisbest/layers/presentation_layer/constants/media_query.dart';
import 'package:islamisbest/layers/presentation_layer/constants/my_textstyle.dart';

class TopTitle extends StatelessWidget {
  final bool onlyTopText;
  final double heightStep, widthStep;
  final String screenName;
  TopTitle({
    this.onlyTopText,
    this.heightStep,
    this.widthStep,
    this.screenName,
  });
  @override
  Widget build(BuildContext context) {
    MediaQuerys().init(context);

    return Container(
      // height: MediaQuerys.heightStep * 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // height: MediaQuerys.heightStep * 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dzemaat",
                  style: TextStyle(
                    height: 6,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                onlyTopText == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            screenName,
                            style: myTextStyle,
                          ),
                          SizedBox(
                            width: MediaQuerys.widthStep * 20,
                          ),
                          // Text(
                          //   "or Login",
                          //   style: TextStyle(
                          //     fontSize: MediaQuerys.widthStep * 50,
                          //     color: Colors.grey,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}