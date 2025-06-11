import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/preprocessing_controller.dart';

class PreprocessingView extends GetView<PreprocessingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Preprocessing Analysis',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade800),
                  ),
                  SizedBox(height: 16),
                  Text('Processing Data...',
                      style: TextStyle(
                          color: Colors.blue.shade800,
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
                  Icon(Icons.data_usage, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No Data Available',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('Run the preprocessing to see results',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          final analysis = controller.analysisResult.value!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(
                    icon: Icons.tune,
                    title: 'Preprocessing Techniques Applied',
                    color: Colors.blue.shade800),
                SizedBox(height: 12),
                _buildTechniqueCard(
                    'Feature Selection', 'Selected 18 most important features'),
                _buildTechniqueCard(
                    'Missing Values', 'Handled in feature Selection'),
                _buildTechniqueCard(
                    'Data Scaling', 'Already provided in the dataset'),

                SizedBox(height: 24),
                _buildSectionHeader(
                    icon: Icons.assessment,
                    title: 'Data Transformation Summary',
                    color: Colors.blue.shade800),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildComparisonCard(
                        title: 'Before \nPreprocessing',
                        icon: Icons.history,
                        color: Colors.orange.shade700,
                        items: {
                          'Original Features': 'All features in the dataset',
                          'Missing Values': 'Represented with -1',
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildComparisonCard(
                        title: 'After \nPreprocessing',
                        icon: Icons.done_all,
                        color: Colors.green.shade700,
                        items: {
                          'Selected Features': '18 most important features',
                          'Missing Values': 'Eliminated through feature selection',
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),
                _buildSectionHeader(
                    icon: Icons.star,
                    title: 'Feature Importance',
                    color: Colors.blue.shade800),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The following features were selected based on their strong relationship with the target:',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade800),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          'ps_ind_01', 'ps_car_15', 'ps_ind_17_bin', 'ps_reg_03',
                          'ps_car_12', 'ps_ind_06_bin', 'ps_ind_03', 'ps_reg_01',
                          'ps_car_02_cat', 'ps_ind_05_cat', 'ps_ind_02_cat',
                          'ps_car_13', 'ps_reg_02', 'ps_ind_07_bin', 'ps_car_04_cat',
                          'ps_ind_16_bin', 'ps_car_03_cat', 'ps_car_07_cat'
                        ].map((feature) => Chip(
                          label: Text(feature,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          backgroundColor: Colors.blue.shade100,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ],
    );
  }

  Widget _buildTechniqueCard(String title, String description) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard({
    required String title,
    required IconData icon,
    required Color color,
    required Map<String, String> items,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: color),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...items.entries.map((entry) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          entry.value,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}