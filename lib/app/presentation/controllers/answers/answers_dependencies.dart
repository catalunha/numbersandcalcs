import 'package:aluno/app/presentation/controllers/answers/answers_controller.dart';
import 'package:get/get.dart';

class AnswersDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnswersController>(() => AnswersController());
  }
}
