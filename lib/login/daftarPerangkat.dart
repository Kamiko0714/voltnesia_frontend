import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'login.dart';
import 'register.dart';

class DaftarPerangkatPage extends StatefulWidget {
  @override
  _DaftarPerangkatPageState createState() => _DaftarPerangkatPageState();
}

class _DaftarPerangkatPageState extends State<DaftarPerangkatPage> {
  final TextEditingController _idPerangkatController = TextEditingController();
  final Dio _dio = Dio();

  Future<void> _verifikasiPerangkat() async {
    final String idPerangkat = _idPerangkatController.text.trim();

    if (idPerangkat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ID Perangkat tidak boleh kosong')),
      );
      return;
    }

    try {
      final response = await _dio.get(
        'http://voltnesia.msibiot.com:8000/esp/registration?id_esp=' + idPerangkat,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perangkat berhasil diverifikasi')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verifikasi gagal: ${response.data['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Perangkat'),
        backgroundColor: Color(0xFFFF15aea2),
      ),
      backgroundColor: Color(0xFFFF15aea2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/login.png',
              width: 240,
              height: 240,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idPerangkatController,
              decoration: InputDecoration(
                labelText: 'Isi ID Perangkat',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifikasiPerangkat,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFfff7e8),
                foregroundColor: Colors.black,
              ),
              child: Text('Verifikasi'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Sudah Punya Akun? login disini',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
