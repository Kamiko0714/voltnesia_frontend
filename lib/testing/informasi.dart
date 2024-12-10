import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Untuk Circular Gauge
import 'package:fl_chart/fl_chart.dart'; // Untuk grafik frekuensi
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import notifikasi

class InformasiPage extends StatefulWidget {
  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  double suhu = 0.0; // Data untuk suhu
  double kondisi = 0.0; // Data untuk kondisi
  List<double> frekuensi = [50, 45, 55, 60, 52]; // Data frekuensi statis
  bool isLoading = false; // Indikator loading
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    // Inisialisasi notifikasi
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidInitialization = AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: androidInitialization);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Set data secara manual (contoh)
    setState(() {
      suhu = 55.0; // Misalnya suhu diatur secara manual
      kondisi = 90.0; // Kondisi diatur ke 90% secara manual

      // Cek suhu dan tampilkan notifikasi jika suhu mencapai 50
      if (suhu >= 50.0) {
        _showNotification();
      }
    });
  }

  // Fungsi untuk menampilkan notifikasi
  Future<void> _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id', 
      'channel_name', 
      channelDescription: 'Channel untuk peringatan suhu',
      importance: Importance.high,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Peringatan Suhu Tinggi!',
      'Suhu perangkat telah mencapai $suhu °C, periksa perangkat segera.',
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15aea2), // Warna latar belakang halaman
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
            // Kondisi Perangkat
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
                      _buildGauge(
                        title: "Suhu",
                        value: suhu,
                        unit: "°C",
                        min: 0,
                        max: 100,
                        color: Colors.blueAccent,
                      ),
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
            // Grafik Frekuensi
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
                  isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFFfff7e8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: LineChart(
                            LineChartData(
                              minY: 10,
                              maxY: 60,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                      frekuensi.length,
                                      (index) => FlSpot(
                                          index.toDouble(), frekuensi[index])),
                                  isCurved: true,
                                  barWidth: 2,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 10,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      return Text('${value.toInt()}hz',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black));
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
