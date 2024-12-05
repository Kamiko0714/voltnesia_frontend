import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'profile.dart';
import 'riwayat.dart';
import 'kontrol.dart';
import 'informasi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio _dio = Dio();
  String biaya = "Rp. 0,00 KW/h";
  String daya = "Hitungan per jam";
  String arus = "Hitungan per jam";
  String tegangan = "Hitungan per jam";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _dio.get('http://voltnesia.msibiot.com:8000/devices?esp_id=testing');
      if (response.statusCode == 200) {
        setState(() {
          biaya = "Rp. ${response.data['biaya']} KW/h";
          daya = "${response.data['daya']} W/jam";
          arus = "${response.data['arus']} A/jam";
          tegangan = "${response.data['tegangan']} V/jam";
        });
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF15aea2),
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            return TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        backgroundColor: Color(0xFFfff7e8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCostCard(),
              SizedBox(height: 1),
              _buildMotivationalText(),
              SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildInfoCard('DAYA', 'Periode : Oktober', daya)),
                  SizedBox(width: 2),
                  Expanded(child: _buildInfoCard('ARUS', 'Periode : Oktober', arus)),
                  SizedBox(width: 8),
                  Expanded(child: _buildInfoCard('TEGANGAN', 'Periode : Oktober', tegangan)),
                ],
              ),
              SizedBox(height: 1),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Kontrol',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informasi',
          ),
        ],
        selectedItemColor: Color(0xFF3a7b7e),
        unselectedItemColor: Color(0xFF3a7b7e),
        backgroundColor: Color(0xFFfff7e8),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => RiwayatPage()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => KontrolPage()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => InformasiPage()));
              break;
          }
        },
      ),
    );
  }

  Widget _buildCostCard() {
    return Card(
      color: Color(0xFFfff7e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biaya bulan ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              biaya,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationalText() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Pengeluaran kamu belum tinggi\nTerus Pantau Penggunaan Listrik Kamu.',
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 20),
        Image.asset(
          'assets/coffe_woman.png',
          height: 240,
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String period, String calculation) {
    return Card(
      color: Color(0xFFfff7e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              period,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              calculation,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
