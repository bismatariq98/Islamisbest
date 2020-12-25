import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamisbest/layers/data_layer/models/video_model.dart';

class VideoEditing {
  VideoModel videoModel;
  List<VideoModel> videoModels = [];
  Future<List<VideoModel>> getVideo() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot data = await firestore.collection("Video").get();
    videoModels = data.docs
        .map((e) => VideoModel(
              videoDescription: e.data()['videoDescription'],
              videoDuration: e.data()['videoDuration'],
              videoId: e.data()['videoId'],
              videoType: e.data()['Type'],
              videoInfo: e.data()['videoInfo'],
              videoLink: e.data()['videoLink'],
              videoName: e.data()['videoName'],
              videoSize: e.data()['videoSize'],
              videoTitle: e.data()['videoTitle'],
            ))
        .toList();
    return videoModels;
  }
}
