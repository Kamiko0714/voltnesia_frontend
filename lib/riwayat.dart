  import 'package:flutter/material.dart';
  import 'package:fl_chart/fl_chart.dart';
  import 'package:dio/dio.dart';

  class RiwayatPage extends StatefulWidget {
    @override
    _RiwayatPageState createState() => _RiwayatPageState();
  }

  class _RiwayatPageState extends State<RiwayatPage> {
    List<double> barChartData = [0]; // Data statis untuk grafik
    List<Map<String, String>> usageData = []; // Data akan diambil dari API
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
          'Authorization': 'Bearer Gix2nFQ1U12Z5Sh7ZvZsnUrAyn3Cku4lIufYBlxzr5eWDw9WdOHXBcFFwVEm36uC'
        },
      ),
    );
    
    // Parse the response and update the usageData list
    List<Map<String, String>> data = List<Map<String, String>>.from(
      response.data.map((item) => {
        'bulan': item['bulan'],
        'periode': item['periode'],
        'penggunaan': item['penggunaan'],
        'total': item['total'],
      }),
    );
    
    // Update state with fetched data
    setState(() {
      usageData = data;
    });
  } catch (e) {
    print('Error fetching data: $e');
  }
}

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
              // Only display data if it's fetched
              if (usageData.isNotEmpty)
                ...usageData.map((data) => _buildRiwayatPengeluaran(
                      data['bulan']!,
                      data['periode']!,
                      data['penggunaan']!,
                      data['total']!,
                    )),
              if (usageData.isEmpty)
                Center(child: CircularProgressIndicator()), // Show loading indicator while fetching data
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
                                return Text('DEC',
                                    style: TextStyle(color: Colors.indigo.shade900));
                              case 1:
                                return Text('',
                                    style: TextStyle(color: Colors.indigo.shade900));
                              case 2:
                                return Text('',
                                    style: TextStyle(color: Colors.indigo.shade900));
                              case 3:
                                return Text('',
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
