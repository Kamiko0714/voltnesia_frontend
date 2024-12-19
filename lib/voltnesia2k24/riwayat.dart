import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dio/dio.dart';
import 'homepage.dart'; // Pastikan file ini sesuai dengan path Anda

class RiwayatPage extends StatefulWidget {
  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<double> barChartData = []; // Data untuk grafik bulanan
  List<Map<String, dynamic>> usageData = []; // Data penggunaan
  String espId = "voltnesia2k24";
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final response = await _dio.get(
        "http://voltnesia.msibiot.com:8000/devices",
        queryParameters: {"esp_id": espId},
        options: Options(
          headers: {
            'Authorization': 'Bearer Gix2nFQ1U12Z5Sh7ZvZsnUrAyn3Cku4lIufYBlxzr5eWDw9WdOHXBcFFwVEm36uC',
          },
        ),
      );

      if (response.data != null && response.data['devices'] != null) {
        List<dynamic> devices = response.data['devices'];

        List<Map<String, dynamic>> data = devices.map((device) {
          return {
            'bulan': device['bulan'] ?? 'Unknown',
            'periode': device['periode'] ?? 'Unknown',
            'penggunaan': device['penggunaan']?.toString() ?? '0',
            'total': device['total']?.toString() ?? '0',
          };
        }).toList();

        List<double> chartData = devices.map((device) {
          return double.tryParse(device['penggunaan']?.toString() ?? '0') ?? 0.0;
        }).toList();

        setState(() {
          usageData = data;
          barChartData = chartData;
        });
      } else {
        print("Error: Data devices tidak ditemukan.");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghapus tombol back
        title: Text(
          'RIWAYAT',
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF15aea2),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF15aea2),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGrafikBulanan(),
            SizedBox(height: 16),
            Text(
              'RIWAYAT PENGELUARAN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8),
            if (usageData.isNotEmpty)
              ...usageData.map((data) => _buildRiwayatPengeluaran(
                    data['bulan']!,
                    data['periode']!,
                    data['penggunaan']!,
                    data['total']!,
                  )),
            if (usageData.isEmpty) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
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

  Widget _buildGrafikBulanan() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      color: Color(0xFFfff7e8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GRAFIK BULANAN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: barChartData.asMap().entries.map((entry) {
                    int index = entry.key;
                    double value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          width: 15,
                          color: Colors.indigo.shade900,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < usageData.length) {
                            return Text(
                              usageData[index]['bulan'] ?? '',
                              style: TextStyle(color: Colors.indigo.shade900),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiwayatPengeluaran(
      String bulan, String periode, String penggunaan, String total) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      color: Color(0xFFfff7e8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$bulan',
              style: TextStyle(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900),
            ),
            SizedBox(height: 8),
            Text(
              'Periode pembayaran: $periode',
              style: TextStyle(fontSize: 14, color: Colors.indigo.shade900),
            ),
            SizedBox(height: 8),
            Text(
              'Penggunaan Listrik: $penggunaan',
              style: TextStyle(fontSize: 14, color: Colors.indigo.shade900),
            ),
            SizedBox(height: 8),
            Text(
              'Total Biaya: $total',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900),
            ),
          ],
        ),
      ),
    );
  }
}
