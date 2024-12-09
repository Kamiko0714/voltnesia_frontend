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
  final Dio _dio = Dio();
  final String espId = "voltnesia2k24";

  String current = "Loading...";
  String power = "Loading...";
  String voltase = "Loading...";
  String energy = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchEnergyData();
  }

  Future<void> _fetchEnergyData() async {
    try {
      final response = await _dio.get(
        "http://voltnesia.msibiot.com:8000/devices",
        queryParameters: {"esp_id": espId},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        var deviceData = data['devices'].firstWhere(
          (device) => device['id_esp'] == espId && device['device_type'] == 'pzem',
          orElse: () => null,
        );

        if (deviceData != null) {
          setState(() {
            current = "${deviceData['current']} A";
            power = "${deviceData['power']} W";
            voltase = "${deviceData['voltase']} V";
            energy = "${deviceData['energy']} KW/h";
          });
        } else {
          _setErrorState("Data not found");
        }
      } else {
        _setErrorState("Failed to load data");
      }
    } catch (e) {
      print("Error fetching data: $e");
      _setErrorState("Error");
    }
  }

  void _setErrorState(String message) {
    setState(() {
      current = message;
      power = message;
      voltase = message;
      energy = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: Color(0xFF15aea2),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Home', style: TextStyle(color: Colors.black)),
      backgroundColor: Color(0xFFfff7e8),
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCostCard(),
            SizedBox(height: 16),
            _buildMotivationalText(),
            SizedBox(height: 16),
            Text(
              'Data Penggunaan Energi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 16),
            _buildInfoRow('Power', power, 'Current', current),
            SizedBox(height: 16),
            _buildInfoRow('Voltase', voltase, 'Energy', energy),
          ],
        ),
      ),
    );
  }

  Widget _buildCostCard() {
    double energyValue = double.tryParse(energy.split(' ').first) ?? 0.0;
    bool isLowEnergy = energyValue < 0.50;

    return Card(
      color: Color(0xFFfff7e8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Energy bulan ini', style: _boldTextStyle()),
            SizedBox(height: 8),
            Text(energy, style: _largeTextStyle()),
            if (isLowEnergy) ...[
              SizedBox(height: 16),
              Text(
                'Perkiraan biaya bulan ini: Rp. ${energyValue * 1160}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
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
            style: _boldTextStyle(),
          ),
        ),
        SizedBox(width: 20),
        Image.asset(
          'assets/coffe_woman.png',
          height: 240,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 100, color: Colors.red);
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title1, String data1, String title2, String data2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildInfoCard(title1, 'Desember', data1)),
        SizedBox(width: 8),
        Expanded(child: _buildInfoCard(title2, 'Desember', data2)),
      ],
    );
  }

  Widget _buildInfoCard(String title, String period, String data) {
    return Card(
      color: Color(0xFFfff7e8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: _boldTextStyle()),
            SizedBox(height: 8),
            Text(period, style: _mediumTextStyle()),
            SizedBox(height: 8),
            Text(data, style: _mediumTextStyle()),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Kontrol'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi'),
      ],
      selectedItemColor: Color(0xFF3a7b7e),
      unselectedItemColor: Color(0xFF3a7b7e),
      backgroundColor: Color(0xFFfff7e8),
      onTap: _onNavigationItemTapped,
    );
  }

  void _onNavigationItemTapped(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = RiwayatPage();
        break;
      case 1:
        page = KontrolPage();
        break;
      case 2:
        page = InformasiPage();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  TextStyle _boldTextStyle() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle _largeTextStyle() {
    return TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle _mediumTextStyle() {
    return TextStyle(fontSize: 16, color: Colors.black);
  }
}
