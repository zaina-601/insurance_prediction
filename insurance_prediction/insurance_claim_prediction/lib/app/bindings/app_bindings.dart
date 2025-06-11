import 'package:get/get.dart';
import '../../controllers/about_controller.dart';
import '../../controllers/data_analysis_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/prediction_controller.dart';
import '../../controllers/preprocessing_controller.dart';
import '../../controllers/visualization_controller.dart';
import '../../services/data_service.dart';
import '../../services/model_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataService());
    Get.lazyPut(() => ModelService());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DataAnalysisController());
    Get.lazyPut(() => PreprocessingController());
    Get.lazyPut(() => VisualizationController());
    Get.lazyPut(() => PredictionController());
    Get.lazyPut(() => AboutController());
  }
}