import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'profile.dart';
import 'riwayat.dart';
import 'kontrol.dart';
import 'informasi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables to hold the ESP data
  String current = "Loading...";
  String power = "Loading...";
  String voltase = "Loading...";
  String energy = "Loading...";
  
  // ESP ID
  final String espId = "voltnesia2k24";

  @override
  void initState() {
    super.initState();
    fetchDeviceData();
  }

  // Fetch data from ESP using Dio
  Future<void> fetchDeviceData() async {
    final Dio dio = Dio();
    final String apiUrl = "http://voltnesia.msibiot.com/devices?esp_id=$espId";

    try {
      final Response response = await dio.get(apiUrl);
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          current = "${response.data['current']} A/jam";
          power = "${response.data['power']} W/jam";
          voltase = "${response.data['voltase']} V/jam";
          energy = "Rp. ${response.data['energy']} KW/h";
        });
      } else {
        setState(() {
          current = power = voltase = energy = "Data tidak tersedia";
        });
      }
    } catch (error) {
      setState(() {
        current = power = voltase = energy = "Error memuat data";
      });
      print("Error fetching data: $error");
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
              SizedBox(height: 10),
              _buildMotivationalText(),
              SizedBox(height: 10),
              Text(
                'Data Penggunaan Energi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildInfoCard('Power', 'Periode : Desember', power)),
                  SizedBox(width: 5),
                  Expanded(child: _buildInfoCard('Current', 'Periode : Desember', current)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildInfoCard('Voltase', 'Periode : Desember', voltase)),
                  SizedBox(width: 5),
                  Expanded(child: _buildInfoCard('Energy', 'Periode : Desember', energy)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: BottomNavigationBar(
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
          ),
        ),
      ),
    );
  }

  Widget _buildCostCard() {
    List<String> energyParts = energy.split(' ');
    double energyValue = 0.0;

    if (energyParts.length > 1) {
      energyValue = double.tryParse(energyParts[1]) ?? 0.0;
    }

    bool isLowEnergy = energyValue < 0.50;

    return SizedBox(
      width: 350,
      child: Card(
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
                'Energy bulan ini',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                energy,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              if (isLowEnergy) ...[
                SizedBox(height: 16),
                Text(
                  'Perkiraan biaya bulan ini: Rp. ${energyValue * 1.160} Kw/h',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ],
          ),
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
