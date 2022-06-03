import 'package:numbersandcalcs/app/presentation/controllers/calcs/calcs_controller.dart';
import 'package:get/get.dart';

class CalcsDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalcsController>(() => CalcsController());
  }
}
