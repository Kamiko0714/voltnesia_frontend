import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Untuk Circular Gauge
import 'package:fl_chart/fl_chart.dart'; // Untuk grafik frekuensi
import 'package:dio/dio.dart'; // Untuk HTTP API dengan Dio

class InformasiPage extends StatefulWidget {
  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  double suhu = 33.7; // Data untuk suhu
  double kondisi = 100.0; // Data untuk kondisi
  List<double> frekuensi = [53]; // Data untuk grafik frekuensi

  final Dio dio = Dio(); // Inisialisasi Dio

  @override
  void initState() {
    super.initState();
    // fetchData(); // Ambil data dari API saat inisialisasi
  }

  Future<void> fetchData() async {
    try {
      // API untuk Circular Gauge (contoh URL)
      final response1 = await dio.get('https://api.example.com/device-status');
      // API untuk Grafik Frekuensi (contoh URL)
      final response2 = await dio.get('https://api.example.com/frequency-data');

      if (response1.statusCode == 200 && response2.statusCode == 200) {
        final data1 = response1.data;
        final data2 = response2.data;

        setState(() {
          suhu = data1['temperature']; // Ambil suhu dari API
          kondisi = data1['condition']; // Ambil kondisi dari API
          frekuensi = List<double>.from(data2['frequency']); // Ambil frekuensi dari API
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INFO PERANGKAT'),
        backgroundColor: Color(0xFFFF15aea2),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFfff7e8),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KONDISI PERANGKAT PINTAR',
                    style: TextStyle(
                      color: Color(0xFFFF15aea2),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Gauge untuk Suhu
                      _buildGauge(
                        title: "Suhu",
                        value: suhu,
                        unit: "°C",
                        min: 0,
                        max: 100,
                        color: Colors.blueAccent,
                      ),
                      // Gauge untuk Kondisi
                      _buildGauge(
                        title: "Kondisi",
                        value: kondisi,
                        unit: "%",
                        min: 0,
                        max: 100,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Color(0xFFfff7e8),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FREKUENSI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Grafik Frekuensi
                  Container(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: List.generate(frekuensi.length, (index) {
                          return BarChartGroupData(x: index, barRods: [
                            BarChartRodData(
                                toY: frekuensi[index],
                                color: Colors.blue,
                                width: 15),
                          ]);
                        }),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text('M-${value.toInt()}');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk Circular Gauge
  Widget _buildGauge(
      {required String title,
      required double value,
      required String unit,
      required double min,
      required double max,
      required Color color}) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: min,
                maximum: max,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  thicknessUnit: GaugeSizeUnit.factor,
                  color: color.withOpacity(0.3),
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: value,
                    width: 0.2,
                    color: color,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '$value $unit',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}