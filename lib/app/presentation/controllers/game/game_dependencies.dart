import 'package:aluno/app/presentation/controllers/game/game_controller.dart';
import 'package:get/get.dart';

class GameDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
  }
}
