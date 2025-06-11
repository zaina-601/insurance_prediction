import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/analysis_result.dart';
import '../models/sample_data.dart';

class DataService extends GetxService {
  Future<AnalysisResult> loadAnalysisResult() async {
    final String response = await rootBundle.loadString('assets/data/analysis_results.json');
    final data = await json.decode(response);
    return AnalysisResult.fromJson(data);
  }

  Future<SampleData> loadSampleData() async {
    final String response = await rootBundle.loadString('assets/data/sample_data.json');
    final data = await json.decode(response);
    return SampleData.fromJson(data);
  }
}