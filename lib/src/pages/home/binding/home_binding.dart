import 'package:get/get.dart';
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';

class HomeBinding with Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
