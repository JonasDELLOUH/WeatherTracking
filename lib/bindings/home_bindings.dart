import 'package:get/get.dart';
import 'package:weather_tracking1/services/weather_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: We will add the dependencies later.
    Get.lazyPut(() => WeatherServices());
    Get.lazyPut(() => HomeController());
  }
}
