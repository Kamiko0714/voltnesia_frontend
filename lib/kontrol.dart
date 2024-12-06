import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class KontrolPage extends StatefulWidget {
  @override
  _KontrolScreenState createState() => _KontrolScreenState();
}

class _KontrolScreenState extends State<KontrolPage> {
  bool _isLampOn = false;
  bool _isOveruse = false;
  bool _isFeature1 = false;
  bool _isFeature2 = false;

  final Dio _dio = Dio();

  Future<void> _sendLampRequest(bool isOn) async {
    try {
      final response = await _dio.post(
        'http://voltnesia.msibiot.com:8000/update-device', // Ganti dengan URL
        data: {'isOn': isOn},
      );

      if (response.statusCode == 200) {
        print('Lamp request successful');
      } else {
        print('Lamp request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending lamp request: $e');
    }
  }

  void _toggleLamp() {
    setState(() {
      _isLampOn = !_isLampOn;
    });

    _sendLampRequest(_isLampOn);
  }

  void _toggleOveruse() {
    setState(() {
      _isOveruse = !_isOveruse;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfff7e8),
      appBar: AppBar(
        title: Text('Kontrol Lampu'),
        backgroundColor: Color(0xFFfff7e8),
      ),
      body: Container(
        color: Color(0xFFfff7e8), // Background color of the page
        child: Container(
          padding: EdgeInsets.all(26.0),
          decoration: BoxDecoration(
            color: Color(0xFFFF15aea2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), // Sudut melengkung di atas kiri
              topRight: Radius.circular(40.0), // Sudut melengkung di atas kanan
            ),
          ),
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
                'manonaktifkan pemberitahuan ketika pengguna\n'
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
                  backgroundColor: Color(0xFFfff7e8),
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
                      color: _isLampOn ? Color(0xFFFFCD31) : Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Lampu',
                      style: TextStyle(
                        fontSize: 18,
                        color: _isLampOn ? Color(0xFFFFCD31) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}