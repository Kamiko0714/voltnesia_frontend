import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart'; // Pastikan MainScreen sudah didefinisikan di sini
import 'package:frontend/login/login.dart'; // Untuk navigasi kembali ke login

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isChecked = false;

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _navigateToNextPage() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua kolom harus diisi.')),
      );
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email tidak valid.')),
      );
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda harus menyetujui syarat dan ketentuan.')),
      );
      return;
    }

    // Jika semua validasi lolos, lanjutkan ke halaman berikutnya
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF15aea2),
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Color(0xFFFF15aea2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama User',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: _toggleCheckbox,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman syarat dan ketentuan
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tampilkan Syarat dan Ketentuan')),
                        );
                      },
                      child: Text(
                        'Dengan ini saya membaca, memahami, dan menyetujui Syarat dan Ketentuan serta Kebijakan Privasi.',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _navigateToNextPage,
                child: Text('Lanjutkan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFfff7e8),
                  minimumSize: Size(double.infinity, 50.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Sudah punya akun? Login di sini',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
