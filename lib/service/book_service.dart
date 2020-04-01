import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:CUbook/class/Book.dart';
import 'dart:convert';
import 'dart:io';
import 'service.dart';


Future<List<Book>> getAllBook() async {
  final response = await http
      .get(url+"/getAllBook"); //need test immediate
  List<dynamic> datas = json.decode(response.body);
  List<Book> books = [];
  for (Map<String, dynamic> json in datas) {
    books.add(Book.fromJson(json));
  }
  return books;
}

Future<int> uploadBook(String bookName, String author, double bookPrice,
    String seller, int amount) async {
  final response = await http.post(url + "/addBook",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode({
        "bookName": bookName,
        "author": author,
        "bookPrice": bookPrice,
        "username": seller,
        "amount": amount
      }));
  return response.statusCode;
}

Future<int> deleteBook(int bookID) async{
  final response=await http.post(url+"/deleteBook",
  headers: {HttpHeaders.contentTypeHeader: "application/json"},
  body: json.encode({
    "bookID" : bookID
  })
  );
  return response.statusCode;
}

Future<List<Book>> userBook(String email) async{
  final response=await http.post(url +"/getUserBook",
  headers: {HttpHeaders.contentTypeHeader:"application/json"},
  body: json.encode({
    "username" : email
  }));
  List<dynamic> datas = json.decode(response.body);
  List<Book> books = [];
  for (Map<String, dynamic> json in datas) {
    books.add(Book.fromJson(json));
  }
  print(books.isEmpty);
  return books;
}