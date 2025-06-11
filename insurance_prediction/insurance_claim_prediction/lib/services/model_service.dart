import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/prediction_input.dart';

class ModelService extends GetxService {
  static const String baseUrl = 'https://bountiful-blessing-production.up.railway.app';

  Future<double> predictWithModel(
    PredictionInput input,
    String modelType,
  ) async {
    try {
      final inputList = input.toJson().values.map((e) => e.toDouble()).toList();

      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'features': inputList,
          'modelType': modelType.toLowerCase(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('prediction')) {
          return data['prediction'];
        } else {
          throw Exception(data['error'] ?? 'Unknown error');
        }
      } else {
        throw Exception(
          'Server error: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Prediction failed: $e');
      rethrow; // Better to rethrow to handle it in the UI
    }
  }
}
