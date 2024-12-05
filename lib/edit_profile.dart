import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Edit Profil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ganti Foto Profil',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            SizedBox(height: 30),
            buildTextField('NAMA', 'CUSTOMER'),
            SizedBox(height: 10),
            buildTextField(
              'NOMOR WHATSAPP',
              '+62',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.flag, size: 20),
              ),
            ),
            SizedBox(height: 10),
            buildTextField('EMAIL', 'CUSTOMER', actionButton: TextButton(
              onPressed: () {},
              child: Text(
                'Ganti Email',
                style: TextStyle(color: Colors.blue),
              ),
            )),
            SizedBox(height: 10),
            buildTextField('ALAMAT', 'CUSTOMER'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('SIMPAN'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, {Widget? prefixIcon, Widget? actionButton}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
        Row(
          children: [
            if (prefixIcon != null) prefixIcon,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            if (actionButton != null) actionButton,
          ],
        )
      ],
    );
  }
}