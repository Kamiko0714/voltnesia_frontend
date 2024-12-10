import 'package:flutter/material.dart';
import 'login/firstpage.dart';
// import 'voltnesia2k24/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Firstpage(),
    );
  }
}