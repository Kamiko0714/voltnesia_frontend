import 'package:flutter/material.dart';
import 'testing/homepage.dart' as Testing;
import 'voltnesia2k24/homepage.dart' as Voltnesia;

class Selection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Homepage'),
      ),
      backgroundColor: Color(0xFF15aea2), // Warna latar belakang Scaffold
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // Jarak dari atas
        child: ListView(
          children: [
            Container(
              color: Color(0xFFfff7e8), // Warna latar belakang ListTile
              child: ListTile(
                leading: Icon(Icons.folder),
                title: Text('ESP ID : testing'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Testing.HomePage()),
                  );
                },
              ),
            ),
            SizedBox(height: 8), // Spasi antar ListTile
            Container(
              color: Color(0xFFfff7e8), // Warna latar belakang ListTile
              child: ListTile(
                leading: Icon(Icons.folder),
                title: Text('ESP ID : voltnesia2k24'),
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
    );
  }
}
