import 'package:flutter/material.dart';
import 'package:frontend/login/login.dart';
import 'package:frontend/testing/riwayat.dart';
// import 'login/firstpage.dart';
import 'selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Selection(),
    );
  }
}