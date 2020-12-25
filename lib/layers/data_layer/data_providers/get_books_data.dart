import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamisbest/layers/data_layer/models/books_model.dart';

class BooksModels {
  List<BooksModel> booksModel = [];
  Future<List<BooksModel>> getBooksData() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    QuerySnapshot data = await firebase.collection("Books").get();
    booksModel = data.docs
        .map((e) => BooksModel(
              bookDescription: e.data()['bookDescription'],
              bookDownloadLink: e.data()['bookDownloadLink'],
              bookDownloadSize: e.data()['bookDownloadSize'],
              bookImage: e.data()['bookImage'],
              bookInfo: e.data()['bookInfo'],
              bookName: e.data()['bookName'],
              bookReview: e.data()['bookReview'],
            ))
        .toList();

    return booksModel;
  }
}
