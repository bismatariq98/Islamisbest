class BooksModel {
  String bookName;
  String bookDownloadLink;
  String bookDownloadSize;
  String bookDescription;
  String bookReview;
  String bookInfo;
  String bookImage;
  BooksModel(
      {this.bookImage,
      this.bookDescription,
      this.bookDownloadLink,
      this.bookDownloadSize,
      this.bookInfo,
      this.bookName,
      this.bookReview});
}

BooksModel booksModel = BooksModel();
