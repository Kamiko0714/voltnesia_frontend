import 'package:flutter/material.dart';
import 'package:frontend/login/firstpage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'edit_profile.dart';
import 'riwayat.dart';
import 'informasi.dart';
import 'kontrol.dart';
import 'homepage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFIL'),
        backgroundColor: Color(0xFFfff7e8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF15aea2),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'NAMA CUSTOMER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                buildListTile(
                  context,
                  'EDIT PROFIL',
                  'Nama, No. Handphone, Email, Alamat',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  ),
                ),
                buildListTile(
                  context,
                  'RIWAYAT',
                  'Pembayaran, Penggunaan Listrik',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RiwayatPage()),
                  ),
                ),
                buildListTile(
                  context,
                  'INFO PERANGKAT',
                  'Kondisi Perangkat, Frekuensi',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformasiPage()),
                  ),
                ),
                buildListTile(
                  context,
                  'KONTROL',
                  'Notifikasi, Kontrol Beban',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KontrolPage()),
                  ),
                ),
                buildListTile(
                  context,
                  'BANTUAN',
                  'Hubungi Kami',
                  null,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Firstpage()),
                  );
              },
              child: Text('Keluar', style: TextStyle(fontSize: 18)),
            ),
          ),
          Text(
            'Ver. 1.01',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, String title, String subtitle, VoidCallback? onTap) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap ?? () {
          if (title == 'BANTUAN') {
            _launchURL();
          }
        },
      ),
    );
  }

  void _launchURL() async {
    const url = 'https://www.instagram.com/voltnesia_indobot';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}