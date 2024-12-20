import 'package:flutter/material.dart';
import 'testing/homepage.dart' as Testing;
import 'voltnesia2k24/homepage.dart' as Voltnesia;

class Selection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfff7e8),
        title: Text('Opsi Device'),
      ),
      backgroundColor: Color(0xFF15aea2), // Warna latar belakang Scaffold
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teks di bawah AppBar
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Text(
              'Silakan pilih perangkat yang ingin Anda pantau : ',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFfff7e8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Spasi antara teks dan ListView
          SizedBox(height: 16.0),
          // ListView untuk ListTile
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0), // Jarak antar ListTile
                    decoration: BoxDecoration(
                      color: Color(0xFFfff7e8), // Warna latar belakang ListTile
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ), // Sudut tumpul lebih pendek
                    ),
                    child: ListTile(
                      leading: Icon(Icons.folder),
                      title: Text('Televisi'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Testing.HomePage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0), // Jarak antar ListTile
                    decoration: BoxDecoration(
                      color: Color(0xFFfff7e8), // Warna latar belakang ListTile
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ), // Sudut tumpul lebih pendek
                    ),
                    child: ListTile(
                      leading: Icon(Icons.folder),
                      title: Text('Lampu Kamar'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Voltnesia.HomePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}