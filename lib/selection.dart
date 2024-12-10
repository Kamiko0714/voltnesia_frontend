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
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('ESP ID : testing'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Testing.HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('ESP ID : voltnesia2k24'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Voltnesia.HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
