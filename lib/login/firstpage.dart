import 'package:flutter/material.dart';
import 'daftarPerangkat.dart'; 

class Firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF15aea2), 
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFFFF15aea2), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/voltnesia.png',
              width: 240,
              height: 240,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat datang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'VOLTNESIA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'SMARTMETER',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Solusi inovatif untuk energi efektif',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Pantau dan optimalkan penggunaan listrik secara real-time dan hemat energi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DaftarPerangkatPage()),
          );
        },
        backgroundColor: Color(0xFFfff7e8), // Warna tombol
        child: Icon(Icons.arrow_forward, color: Colors.black), // Warna ikon tombol
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}