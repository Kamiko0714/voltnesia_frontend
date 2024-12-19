import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'profile.dart';
import 'riwayat.dart';
import 'kontrol.dart';
import 'informasi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String current = "10"; // Simulasi data
  String power = "950"; // Simulasi data
  String voltase = "220"; // Simulasi data
  String energy = "0.45"; // Simulasi data
  String bulan = ""; // Variabel bulan

  @override
  void initState() {
    super.initState();
    _loadLocalEnergyData(); // Mengambil data lokal
    _setCurrentMonth(); // Mengatur bulan saat ini
  }

  Future<void> _loadLocalEnergyData() async {
    // Data simulasi untuk pengujian lokal
    setState(() {
      current = "10";
      power = "950";
      voltase = "220";
      energy = "0.45";

      // Jika power lebih dari 1000 W, tampilkan notifikasi
      double powerValue = double.tryParse(power.split(' ').first) ?? 0.0;
      if (powerValue >= 1000) {
        _showWarningNotification();
      }
    });
  }

  Future<void> _showWarningNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'energy_channel',
      'Energy Alerts',
      channelDescription: 'This channel is used for energy consumption alerts.',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Peringatan Penggunaan Energi Tinggi',
      'Power penggunaan listrik melebihi batas aman (1000 W). Periksa perangkat Anda!',
      notificationDetails,
    );
  }

  void _setCurrentMonth() {
    final now = DateTime.now(); // Mendapatkan tanggal dan waktu saat ini
    final monthNames = [
      "Januari", "Februari", "Maret", "April", "Mei", "Juni",
      "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ];
    setState(() {
      bulan = monthNames[now.month - 1]; // Mengatur bulan sesuai dengan bulan saat ini
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          color: Color(0xFF15aea2), // Warna latar belakang hijau
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCostCard(),
                  _buildMotivationalText(),
                  SizedBox(height: 16),
                  _buildEnergyUsageCard(), // Kartu "Data Penggunaan Energi"
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: Color(0xFF15aea2), // Warna latar belakang hijau
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: TextButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, color: Colors.black),
            SizedBox(width: 8),
            Text('Profile', style: TextStyle(color: Colors.black)),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
      ),
      backgroundColor: Color(0xFFfff7e8),
      elevation: 0,
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
            Text('Energy bulan $bulan', style: _boldTextStyle()),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: energy, // Teks energy
                    style: _largeTextStyle().copyWith(color: Color(0xFF3a7b7e)), // Warna hijau
                  ),
                  TextSpan(
                    text: ' KW/h', // Teks "KW/h"
                    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), // Warna default (hitam)
                  ),
                ],
              ),
            ),
            if (isLowEnergy)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Perkiraan biaya bulan ini: Rp.',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${energyValue * 1160}',
                      style: TextStyle(fontSize: 20, color: Color(0xFF3a7b7e), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFfff7e8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Pengeluaran kamu belum tinggi\nTerus Pantau Penggunaan Listrik Kamu.',
                  style: _boldTextStyle(),
                ),
              ),
              Positioned(
                top: 10,
                right: -10,
                child: Transform.rotate(
                  angle: 3.14159 / 4,
                  child: Container(
                    width: 15,
                    height: 15,
                    color: Color(0xFFfff7e8),
                  ),
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildEnergyUsageCard() {
    return Card(
      color: Color(0xFFfff7e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Mengatur sudut tumpul
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center( // Memastikan konten berada di tengah secara horizontal
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Rata tengah secara vertikal
                crossAxisAlignment: CrossAxisAlignment.center, // Rata tengah secara horizontal
                children: [
                  Text(
                    'Data Penggunaan Energi',
                    style: _boldTextStyle(),
                    textAlign: TextAlign.center, // Rata tengah teks
                  ),
                  Text(
                    bulan,
                    style: _bulanTextStyle(),
                    textAlign: TextAlign.center, // Rata tengah teks
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildShadowBox(
                    child: _buildEnergyDataRow('Arus', current, unit: 'Ampere'),
                  ),
                ),
                SizedBox(width: 10), // Jarak antara shadow box
                Expanded(
                  child: _buildShadowBox(
                    child: _buildEnergyDataRow('Daya', power, unit: 'Watt'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Jarak antara baris pertama dan kedua
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150, // Lebar statis
                  height: 125, // Tinggi statis
                  child: _buildShadowBox(
                    child: _buildEnergyDataRow('Tegangan', voltase, unit: 'Volt'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShadowBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFfff7e8), // Warna latar belakang shadow box
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Efek bayangan
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildEnergyDataRow(String label, String value, {required String unit}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Menengahkan secara vertikal
      crossAxisAlignment: CrossAxisAlignment.center, // Menengahkan secara horizontal
      children: [
        Text(
          '$label :', // Label (misal: "Arus :", "Daya :", "Tegangan :")
          style: _boldTextStyle(), // Gaya teks untuk label (lebih kecil)
          textAlign: TextAlign.center, // Memastikan teks berada di tengah
        ),
        SizedBox(height: 4), // Jarak antara label dan nilai
        Text(
          value, // Nilai (misal: "10", "950", "220")
          style: _largeValueTextStyle(), // Gaya teks untuk angka (lebih besar)
          textAlign: TextAlign.center, // Memastikan teks berada di tengah
        ),
        SizedBox(height: 4), // Jarak antara nilai dan satuan
        Text(
          unit, // Satuan (misal: "Ampere", "Watt", "Volt")
          style: _boldTextStyle(), // Gaya teks untuk satuan (lebih kecil)
          textAlign: TextAlign.center, // Memastikan teks berada di tengah
        ),
      ],
    );
  }

Widget _buildBottomNavigationBar() {
  return ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Membuat sudut tumpul di atas
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 50), // Menambahkan margin di sisi kanan dan kiri
      decoration: BoxDecoration(
        color: Color(0xFFfff7e8), // Warna latar belakang
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Sudut tumpul di atas
      ),
      constraints: BoxConstraints(
        maxWidth: 300, // Membatasi lebar maksimum lebih kecil
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Kontrol'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi'),
        ],
        selectedItemColor: Color(0xFF3a7b7e),
        unselectedItemColor: Color(0xFF3a7b7e),
        backgroundColor: Colors.transparent, // Transparan agar dekorasi Container terlihat
        onTap: _onNavigationItemTapped,
        elevation: 0, // Menghilangkan bayangan bawaan
      ),
    ),
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
        page = HomePage();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  TextStyle _boldTextStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle _largeTextStyle() {
    return TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle _smallLabelTextStyle() {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black);
  }

  TextStyle _largeValueTextStyle() {
    return TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color(0xFF3a7b7e));
  }

  TextStyle _bulanTextStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3a7b7e));
  }

  TextStyle _smallUnitTextStyle() {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black);
  }
}