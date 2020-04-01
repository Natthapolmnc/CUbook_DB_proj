import 'package:flutter/material.dart';
import "page/LoginPage.dart";

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.pinkAccent,
        primaryColor: Color(0xFFEB86B1),
        fontFamily: "CU",
      ),
      title: "CUbook",
      home: LoginPage()
    );
  }
}
