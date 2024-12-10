import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'homepage.dart';

class KontrolPage extends StatefulWidget {
  @override
  _KontrolScreenState createState() => _KontrolScreenState();
}

class _KontrolScreenState extends State<KontrolPage> {
  bool _isLampOn = false;
  bool _isOveruse = false;
  bool _isFeature1 = false;
  bool _isFeature2 = false;
  Dio _dio = Dio();

  // Ganti dengan URL endpoint API Anda
  final String _apiUrl = "http://voltnesia.msibiot.com:8000/update-device"; // Ubah sesuai URL API Anda
  final String _apiToken = "Gix2nFQ1U12Z5Sh7ZvZsnUrAyn3Cku4lIufYBlxzr5eWDw9WdOHXBcFFwVEm36uC"; // Token API

  // Fungsi untuk mengirim data ke API
  Future<void> _updateLampStatus(bool status) async {
    try {
      final response = await _dio.post(
        _apiUrl,
        data: {
          'esp_id': 'voltnesia2k24',
          'device_id': 'relay-2',
          'device_newdata': {'status': status},
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiToken', // Menambahkan token ke header
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Status lampu berhasil diperbarui: $status');
      } else {
        print('Gagal memperbarui status lampu: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saat mengirim data: $e');
    }
  }

  // Fungsi untuk toggle lamp dan memperbarui API
  void _toggleLamp() async {
    setState(() {
      _isLampOn = !_isLampOn; // Toggle status lampu
    });

    await _updateLampStatus(_isLampOn); // Kirim status terbaru ke API
  }

  // Fungsi untuk toggle fitur lainnya
  void _toggleFeature1() {
    setState(() {
      _isFeature1 = !_isFeature1;
    });
  }

  void _toggleFeature2() {
    setState(() {
      _isFeature2 = !_isFeature2;
    });
  }

  void _toggleOveruse() {
    setState(() {
      _isOveruse = !_isOveruse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfff7e8),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        title: Text(
          'Kontrol Lampu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFF15aea2),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFfff7e8),
        child: Container(
          padding: EdgeInsets.all(26.0),
          decoration: BoxDecoration(
            color: Color(0xFFFF15aea2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'KONTROL',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'Tekan tombol yang tersedia untuk menghidupkan\n'
                  'atau menonaktifkan pemberitahuan ketika pengguna\n'
                  'tidak menggunakan aplikasi.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'PERINGATAN KONDISI PERANGKAT PINTAR',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 10),
                    Switch(
                      value: _isFeature1,
                      onChanged: (value) {
                        _toggleFeature1();
                      },
                      activeColor: Colors.grey,
                      activeTrackColor: Color(0xFFfff7e8),
                      inactiveThumbColor: Color(0xFFfff7e8),
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'PENGGUNAAN LISTRIK BERLEBIHAN',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 10),
                    Switch(
                      value: _isOveruse,
                      onChanged: (value) {
                        _toggleOveruse();
                      },
                      activeColor: Colors.grey,
                      activeTrackColor: Color(0xFFfff7e8),
                      inactiveThumbColor: Color(0xFFfff7e8),
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'KONTROL BEBAN',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Melakukan kontrol terhadap relay yang tersedia\n'
                  'pada sistem, untuk mengirim sinyal bertujuan untuk\n'
                  'menyalakan atau menonaktifkan lampu teras.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'TEKAN UNTUK MENYALAKAN\n'
                  'TEKAN LAGI UNTUK MEMATIKAN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleLamp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[100],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: _isLampOn ? Color(0xFFFFCD31) : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        _isLampOn ? Icons.lightbulb : Icons.lightbulb_outline,
                        color: _isLampOn ? Color(0xFFFFCD31) : Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Lampu',
                        style: TextStyle(
                          fontSize: 18,
                          color: _isLampOn ? Color(0xFFFFCD31) : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera),
            label: 'Kontrol',
          ),
        ],
        selectedItemColor: Colors.indigo.shade900,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }
}
