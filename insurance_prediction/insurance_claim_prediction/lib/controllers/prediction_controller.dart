import 'package:get/get.dart';
import '../services/model_service.dart';
import '../models/prediction_input.dart';

class PredictionController extends GetxController {
  final ModelService modelService = Get.find();
  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxDouble predictionResult = 0.0.obs;
  final RxString selectedModel = 'logistic_regression'.obs;

  final PredictionInput input = PredictionInput(
    psInd01: 0,
    psCar15: 0,
    psInd17Bin: 0,
    psReg03: 0,
    psCar12: 0,
    psInd06Bin: 0,
    psInd03: 0,
    psReg01: 0,
    psCar02Cat: 0,
    psInd05Cat: 0,
    psInd02Cat: 0,
    psCar13: 0,
    psReg02: 0,
    psInd07Bin: 0,
    psCar04Cat: 0,
    psInd16Bin: 0,
    psCar03Cat: 0,
    psCar07Cat: 0,
  );

  Future<void> predict() async {
    try {
      isLoading(true);

      final result = await modelService.predictWithModel(
        input,
        selectedModel.value,
      );

      predictionResult.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Prediction failed: $e');
    } finally {
      isLoading(false);
    }
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  void changeModel(String model) {
    selectedModel.value = model;
  }
}
