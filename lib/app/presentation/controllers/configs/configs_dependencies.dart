import 'package:aluno/app/presentation/controllers/configs/configs_controller.dart';
import 'package:get/get.dart';

class ConfigsDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigsController>(() => ConfigsController());
  }
}
