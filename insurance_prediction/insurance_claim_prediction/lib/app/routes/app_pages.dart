import 'package:get/get.dart';
import '../../views/about_view.dart';
import '../../views/data_analysis_view.dart';
import '../../views/home_view.dart';
import '../../views/prediction_view.dart';
import '../../views/preprocessing_view.dart';
import '../../views/visualization_view.dart';
import '../bindings/app_bindings.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.DATA_ANALYSIS,
      page: () => DataAnalysisView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.PREPROCESSING,
      page: () => PreprocessingView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.VISUALIZATION,
      page: () => VisualizationView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.PREDICTION,
      page: () => PredictionView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => AboutPage(),
      binding: AppBindings(),
    ),
  ];
}