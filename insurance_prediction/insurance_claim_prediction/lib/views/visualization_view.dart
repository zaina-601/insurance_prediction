import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/visualization_controller.dart';

class VisualizationView extends GetView<VisualizationController> {
  final Color primaryColor = Color(0xFF4E35AA);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Visualizations Dashboard',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.deepPurple.shade800),
                  ),
                  SizedBox(height: 16),
                  Text('Generating Visualizations...',
                      style: TextStyle(
                          color: Colors.deepPurple.shade800,
                          fontSize: 16)),
                ],
              ),
            );
          }

          if (controller.analysisResult.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_chart, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No Visualization Data',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('Run the analysis to generate visualizations',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          final analysis = controller.analysisResult.value!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [

                // Target Distribution
                if (analysis.targetDistribution != null) ...[
                  _buildSectionHeader(
                      icon: Icons.stacked_bar_chart,
                      title: 'Target Variable Distribution',
                      color: Colors.deepPurple.shade800),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 280,
                            child: SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700),
                                axisLine: AxisLine(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700),
                                axisLine: AxisLine(width: 0),
                              ),
                              series: <ColumnSeries<
                                  MapEntry<String, dynamic>, String>>[
                                ColumnSeries<MapEntry<String, dynamic>, String>(
                                  dataSource: analysis.targetDistribution!
                                      .entries
                                      .toList(),
                                  xValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.key,
                                  yValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.value,
                                  dataLabelSettings:
                                  DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(fontSize: 10)),
                                  color: Colors.deepPurple.shade400,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
                // Heatmap Section
                _buildSectionHeader(
                    icon: Icons.grid_on,
                    title: 'Feature Correlation Heatmap',
                    color: Colors.deepPurple.shade800),
                SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          'Feature Correlation Matrix',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade800),
                        ),
                        SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/heatmap.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Heatmap showing correlation between selected features',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Feature Distributions
                if (analysis.descriptiveStats != null) ...[
                  _buildSectionHeader(
                      icon: Icons.multiline_chart,
                      title: 'Feature Statistics',
                      color: Colors.deepPurple.shade800),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 280,
                            child: SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700),
                                axisLine: AxisLine(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700),
                                axisLine: AxisLine(width: 0),
                              ),
                              legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom),
                              series: <ColumnSeries<
                                  MapEntry<String, dynamic>, String>>[
                                ColumnSeries<MapEntry<String, dynamic>, String>(
                                  dataSource: analysis.descriptiveStats!
                                      .entries
                                      .take(5)
                                      .toList(),
                                  xValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.key,
                                  yValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.value['mean'],
                                  name: 'Mean',
                                  dataLabelSettings:
                                  DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(fontSize: 10)),
                                  color: Colors.amber.shade600,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                ),
                                ColumnSeries<MapEntry<String, dynamic>, String>(
                                  dataSource: analysis.descriptiveStats!
                                      .entries
                                      .take(5)
                                      .toList(),
                                  xValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.key,
                                  yValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.value['std'],
                                  name: 'Std Dev',
                                  dataLabelSettings:
                                  DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(fontSize: 10)),
                                  color: Colors.teal.shade400,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],

                // Group Distribution
                if (analysis.groupDistribution != null) ...[
                  _buildSectionHeader(
                      icon: Icons.pie_chart,
                      title: 'Group-wise Distribution',
                      color: Colors.deepPurple.shade800),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 280,
                            child: SfCircularChart(
                              legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom),
                              series: <PieSeries<MapEntry<String, dynamic>,
                                  String>>[
                                PieSeries<MapEntry<String, dynamic>, String>(
                                  dataSource:
                                  analysis.groupDistribution!.entries.toList(),
                                  xValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.key,
                                  yValueMapper:
                                      (MapEntry<String, dynamic> entry, _) =>
                                  entry.value,
                                  dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(fontSize: 10)),
                                  dataLabelMapper:
                                      (MapEntry<String, dynamic> data, _) =>
                                  '${data.key}: ${data.value.toStringAsFixed(1)}%',
                                  explode: true,
                                  explodeIndex: 0,
                                  explodeOffset: '10%',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(
      {required IconData icon, required String title, required Color color}) {
    return Row(
      children: [
        Icon(icon, size: 28, color: color),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ],
    );
  }
}