import 'package:get/get.dart';
import '../services/data_service.dart';
import '../models/analysis_result.dart';

class VisualizationController extends GetxController {
  final DataService dataService = Get.find();
  final Rx<AnalysisResult?> analysisResult = Rx<AnalysisResult?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading(true);
      analysisResult.value = await dataService.loadAnalysisResult();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }
}