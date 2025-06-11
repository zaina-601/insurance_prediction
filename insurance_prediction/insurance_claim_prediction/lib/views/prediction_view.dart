import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prediction_controller.dart';

class PredictionView extends GetView<PredictionController> {
  // Create a list of TextEditingControllers to maintain input values
  final List<TextEditingController> _controllers = List.generate(18, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Risk Prediction',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.currentTabIndex.value == 0) {
                  return _buildInputForm();
                } else {
                  return _buildResultsView();
                }
              }),
            ),
            Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  )],
              ),
              child: BottomNavigationBar(
                currentIndex: controller.currentTabIndex.value,
                onTap: controller.changeTab,
                selectedItemColor: Colors.teal.shade700,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.input),
                    label: 'Input Features',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.analytics),
                    label: 'Prediction Results',
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Prediction Model',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedModel.value,
                        items: [
                          'logistic_regression',
                          'decision_tree',
                          'random_forest',
                          'naive_bayes',
                          'ann',
                          'knn',
                        ].map((model) {
                          return DropdownMenuItem(
                            value: model,
                            child: Text(
                              model.replaceAll('_', ' ').toUpperCase(),
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) => controller.changeModel(value!),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          Text(
            'Enter Feature Values',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
            ),
          ),
          SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildNumberInput('ps_ind_01', 0, (value) => controller.input.psInd01 = value),
              _buildNumberInput('ps_car_15', 1, (value) => controller.input.psCar15 = value),
              _buildNumberInput('ps_ind_17_bin', 2, (value) => controller.input.psInd17Bin = value),
              _buildNumberInput('ps_reg_03', 3, (value) => controller.input.psReg03 = value),
              _buildNumberInput('ps_car_12', 4, (value) => controller.input.psCar12 = value),
              _buildNumberInput('ps_ind_06_bin', 5, (value) => controller.input.psInd06Bin = value),
              _buildNumberInput('ps_ind_03', 6, (value) => controller.input.psInd03 = value),
              _buildNumberInput('ps_reg_01', 7, (value) => controller.input.psReg01 = value),
              _buildNumberInput('ps_car_02_cat', 8, (value) => controller.input.psCar02Cat = value),
              _buildNumberInput('ps_ind_05_cat', 9, (value) => controller.input.psInd05Cat = value),
              _buildNumberInput('ps_ind_02_cat', 10, (value) => controller.input.psInd02Cat = value),
              _buildNumberInput('ps_car_13', 11, (value) => controller.input.psCar13 = value),
              _buildNumberInput('ps_reg_02', 12, (value) => controller.input.psReg02 = value),
              _buildNumberInput('ps_ind_07_bin', 13, (value) => controller.input.psInd07Bin = value),
              _buildNumberInput('ps_car_04_cat', 14, (value) => controller.input.psCar04Cat = value),
              _buildNumberInput('ps_ind_16_bin', 15, (value) => controller.input.psInd16Bin = value),
              _buildNumberInput('ps_car_03_cat', 16, (value) => controller.input.psCar03Cat = value),
              _buildNumberInput('ps_car_07_cat', 17, (value) => controller.input.psCar07Cat = value),
            ],
          ),

          SizedBox(height: 24),
          Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: controller.isLoading.value ? null : () => controller.predict(),
              child: controller.isLoading.value
                  ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
                  : Text(
                'PREDICT RISK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNumberInput(String label, int index, Function(double) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _controllers[index],
        decoration: InputDecoration(
          labelText: label.replaceAll('_', ' ').toUpperCase(),
          labelStyle: TextStyle(
            fontSize: 12,
            color: Colors.teal.shade700,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) {
          onChanged(double.tryParse(value) ?? 0);
        },
      ),
    );
  }

  Widget _buildResultsView() {
    return Obx(() {
      if (controller.predictionResult.value == 0.0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.analytics_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No Prediction Results Yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Go to Input tab and run a prediction',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      }

      final isHighRisk = controller.predictionResult.value > 0.5;
      final riskLevel = isHighRisk ? 'HIGH RISK' : 'LOW RISK';

      // THIS IS THE CRITICAL CHANGE - CALCULATE INVERSE CONFIDENCE
      final confidenceValue = isHighRisk
          ? controller.predictionResult.value
          : 1 - controller.predictionResult.value;
      final confidence = '${(confidenceValue * 100).toStringAsFixed(0)}%';

      final riskColor = isHighRisk ? Colors.red.shade700 : Colors.green.shade700;
      final bgColor = isHighRisk ? Colors.red.shade50 : Colors.green.shade50;
      return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'MODEL USED',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      controller.selectedModel.value.replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'PREDICTION RESULT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    riskLevel,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Confidence Level',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    confidence,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'INTERPRETATION',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      isHighRisk
                          ? 'Based on the analysis, this customer has a significantly higher probability of filing an insurance claim. Consider additional review or risk mitigation strategies.'
                          : 'The analysis indicates this customer presents a lower risk profile with minimal probability of filing a claim.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}