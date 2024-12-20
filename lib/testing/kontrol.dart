import 'package:flutter/material.dart';
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

  // Fungsi untuk toggle lamp dan memperbarui status lokal
  void _toggleLamp() {
    setState(() {
      _isLampOn = !_isLampOn; // Toggle status lampu
    });
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
        title: Text('KONTROL', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFF15aea2),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
        ),
      ),
      body: Container(
        color: Color(0xFFFF15aea2),
        child: Container(
          padding: EdgeInsets.all(26.0),
          decoration: BoxDecoration(
            color: Color(0xFFfff7e8),
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
                  'NOTIFIKASI',
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
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFfff7e8), // Warna latar belakang kotak
                    borderRadius: BorderRadius.circular(10.0), // Sudut kotak yang melengkung
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Efek bayangan
                      ),
                    ],
                  ),
  child: Column(
    children: [
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Warna border
              width: 2.0, // Ketebalan border
            ),
            borderRadius: BorderRadius.circular(50.0), // Jika Anda ingin border melengkung
          ),
          child: Switch(
            value: _isFeature1,
            onChanged: (value) {
              _toggleFeature1();
            },
            activeColor: Color(0xFFFF15aea2),
            activeTrackColor: Color(0xFFfff7e8),
            inactiveThumbColor: Color(0xFFFF15aea2),
            inactiveTrackColor: Color(0xFFfff7e8),
          ),
        )
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Warna border
                      width: 2.0, // Ketebalan border
                    ),
                    borderRadius: BorderRadius.circular(50.0), // Jika Anda ingin border melengkung
                  ),
                  child: Switch(
                    value: _isOveruse,
                    onChanged: (value) {
                      _toggleOveruse();
                    },
                    activeColor: Color(0xFFFF15aea2),
                    activeTrackColor: Color(0xFFfff7e8),
                    inactiveThumbColor: Color(0xFFFF15aea2),
                    inactiveTrackColor: Color(0xFFfff7e8),
                  ),
                )
                        ],
                      ),
                    ],
                  ),
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
                Container(
                  padding: EdgeInsets.all(20),
                  width: 2000,
                  decoration: BoxDecoration(
                    color: Color(0xFFfff7e8), // Warna latar belakang kotak
                    borderRadius: BorderRadius.circular(15), // Sudut kotak
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}