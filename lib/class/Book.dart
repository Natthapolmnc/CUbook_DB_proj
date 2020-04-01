import 'dart:convert';

Book postFromJson(String str) {
  final jsonData = json.decode(str);
  return Book.fromJson(jsonData);
}

String postToJson(Book data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Book {
  int bookId;
  String bookName;
  String author;
  double bookPrice;
  String seller;
  int amount;

  Book(
      {this.bookId,
      this.bookName,
      this.author,
      this.bookPrice,
      this.seller,
      this.amount});
      
  factory Book.fromJson(Map<String, dynamic> json) => new Book(
      bookId: json["bookID"],
      bookName: json["bookName"],
      author: json["author"],
      bookPrice: double.parse(json["bookPrice"].toString()),
      seller: json["fk_book_username"],
      amount: json["numberAvaiable"]);

  Map<String, dynamic> toJson() => {
        "bookID": this.bookId,
        "bookName": this.bookName,
        "author": this.author,
        "bookPrice": this.bookPrice,
        "fk_book_username": this.seller,
        "amount": this.amount
      };
}
