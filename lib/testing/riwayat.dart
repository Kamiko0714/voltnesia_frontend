import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RiwayatPage extends StatefulWidget {
  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<double> barChartData = [10, 20, 30, 25, 15]; // Data statis untuk grafik
  List<Map<String, String>> usageData = [
    {
      'bulan': 'Januari',
      'periode': '2024',
      'penggunaan': '150 kWh',
      'total': 'Rp 300,000',
    },
    {
      'bulan': 'Februari',
      'periode': '2024',
      'penggunaan': '120 kWh',
      'total': 'Rp 240,000',
    },
    // Tambahkan data lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RIWAYAT',
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF15aea2),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo.shade900),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color(0xFFFF15aea2),
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
            // Display data statis
            ...usageData.map((data) => _buildRiwayatPengeluaran(
                  data['bulan']!,
                  data['periode']!,
                  data['penggunaan']!,
                  data['total']!,
                )),
          ],
        ),
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
            SizedBox(height: 8),
            Text(
              'Monitor penggunaan listrik bulanan Anda. Kurangi konsumsi untuk menghemat lebih banyak!',
              style: TextStyle(fontSize: 14, color: Colors.indigo.shade900),
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
                          switch (value.toInt()) {
                            case 0:
                              return Text('JAN',
                                  style: TextStyle(color: Colors.indigo.shade900));
                            case 1:
                              return Text('FEB',
                                  style: TextStyle(color: Colors.indigo.shade900));
                            case 2:
                              return Text('MAR',
                                  style: TextStyle(color: Colors.indigo.shade900));
                            case 3:
                              return Text('APR',
                                  style: TextStyle(color: Colors.indigo.shade900));
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}k',
                            style: TextStyle(color: Colors.indigo.shade900),
                          );
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
              'BULAN: $bulan',
              style: TextStyle(
                  fontSize: 16,
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
