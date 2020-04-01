import 'package:http/http.dart' as http;
import 'dart:async';
import "service.dart";
import 'dart:convert';
import 'package:CUbook/class/Book.dart';
import 'dart:io';

Future<int> order(List<Book> books, String email, int payment) async{
  List<int> booksId = [];
  for (Book i in books) {
    booksId.add(i.bookId);
  }
  final response = await http.post(url+"/order", headers: {
    HttpHeaders.contentTypeHeader: "application/json"
  }, body: json.encode({
    "bookID": booksId,
    "buyerUsername": email,
    "payment": payment,
  }));
  return response.statusCode;
}
