import 'package:CUbook/service/service.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'dart:async';
import 'package:CUbook/class/User.dart';
import 'dart:io';

Future<int> register(User user) async {
  final response = await http.post(url + "/register",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: postToJson(user));
  return response.statusCode;
}

Future<int> login(String email, String password) async {
  final response = await http.post(url + "/login",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode({
        "usr": email,
        "pwd": password,
      }));
  return response.statusCode;
}

Future<int> getBalance(String email) async {
  final response = await http.post(url + "/getUserBalance",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode({
        "username": email,
      }));
  List<dynamic> data= json.decode(response.body);
  return data[0]["balance"];
}

Future<int> updateBalance(String email, double addBalance) async{
  final response = await http.post(
    url + "/updateBalance",
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: json.encode({
      "username":email,
      "addedBalance":addBalance
    })
  );
  return response.statusCode;
}
