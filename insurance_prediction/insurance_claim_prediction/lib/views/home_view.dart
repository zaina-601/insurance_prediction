import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/routes/app_pages.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
      title: Text(
      'Insurance Claim Prediction',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.blue[800],
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
    bottom: Radius.circular(35),
    ),
    )),
    body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    SizedBox(height: 20),
    Text(
    'Welcome to InsuranceAI',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue[900],
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Text(
    'Predict claim likelihood with machine learning models',
    style: TextStyle(
    fontSize: 16,
    color: Colors.grey[600],
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 40),
    Expanded(
    child: GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 20,
    crossAxisSpacing: 20,
    childAspectRatio: 1.2,
    children: [
    _buildFeatureCard(
    icon: Icons.analytics,
    title: 'Make Prediction',
    route: Routes.PREDICTION,
    color: Colors.blue[600]!,
    ),
    _buildFeatureCard(
    icon: Icons.data_usage,
    title: 'Data Analysis',
    route: Routes.DATA_ANALYSIS,
    color: Colors.green[600]!,
    ),
    _buildFeatureCard(
    icon: Icons.tune,
    title: 'Preprocessing',
    route: Routes.PREPROCESSING,
    color: Colors.orange[600]!,
    ),
    _buildFeatureCard(
    icon: Icons.insights,
    title: 'Visualizations',
    route: Routes.VISUALIZATION,
    color: Colors.purple[600]!,
    ),
    _buildFeatureCard(
    icon: Icons.info,
    title: 'About',
    route: Routes.ABOUT,
    color: Colors.teal[600]!,
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String route,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Get.toNamed(route),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}