import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Untuk Circular Gauge
import 'package:fl_chart/fl_chart.dart'; // Untuk grafik frekuensi
import 'homepage.dart';

class InformasiPage extends StatefulWidget {
  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  double suhu = 0.0; // Data untuk suhu
  double kondisi = 0.0; // Data untuk kondisi
  List<double> frekuensi = [50, 45, 55, 60, 52]; // Data frekuensi statis
  bool isLoading = false; // Indikator loading

  @override
  void initState() {
    super.initState();

    // Set data secara manual (contoh)
    setState(() {
      suhu = 55.0; // Misalnya suhu diatur secara manual
      kondisi = 90.0; // Kondisi diatur ke 90% secara manual
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfff7e8),
      appBar: AppBar(
        title: Text('INFO PERANGKAT', style: TextStyle(color: Colors.black)),
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
                  'KONDISI PERANGKAT PINTAR',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'Informasi terkini tentang suhu dan kondisi perangkat pintar Anda.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350, //masih harus di setting biar pas
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFfff7e8), // Warna latar belakang kotak
                    borderRadius: BorderRadius.circular(25.0), // Sudut kotak yang melengkung
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5, // Mengurangi spread radius untuk bayangan lebih kecil
                        blurRadius: 5, // Mengurangi blur radius untuk bayangan lebih tipis
                        offset: Offset(0, 5), // Mengurangi offset untuk bayangan lebih kecil
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildGauge(
                        title: "Suhu",
                        value: suhu,
                        unit: "°C",
                        min: 0,
                        max: 100,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 20), // Jarak antara gauge suhu dan kondisi
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
                ),
                SizedBox(height: 20),
                Text(
                  'FREKUENSI',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Grafik frekuensi perangkat pintar Anda.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350, //masih harus di setting biar pas
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFfff7e8), // Warna latar belakang kotak
                    borderRadius: BorderRadius.circular(10.0), // Sudut kotak yang melengkung
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5, // Mengurangi spread radius untuk bayangan lebih kecil
                        blurRadius: 5, // Mengurangi blur radius untuk bayangan lebih tipis
                        offset: Offset(0, 5), // Mengurangi offset untuk bayangan lebih kecil
                      ),
                    ],
                  ),
                  child: isLoading
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
                ),
              ],
            ),
          ),
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