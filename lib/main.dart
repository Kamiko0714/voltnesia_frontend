import 'package:flutter/material.dart';
import 'login/firstpage.dart';
// import 'testing/homepage.dart';
// import 'selection.dart';
// import 'login/register.dart';
// import 'voltnesia2k24/kontrol.dart';

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