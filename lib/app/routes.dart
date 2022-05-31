import 'package:aluno/app/presentation/controllers/answers/answers_dependencies.dart';
import 'package:aluno/app/presentation/controllers/calcs/calcs_dependencies.dart';
import 'package:aluno/app/presentation/controllers/configs/configs_dependencies.dart';
import 'package:aluno/app/presentation/views/answers/answers_page.dart';
import 'package:aluno/app/presentation/views/calcs/calcs_page.dart';
import 'package:aluno/app/presentation/views/configs/configs_page.dart';
import 'package:get/get.dart';

class Routes {
  // static const splash = '/';

  static const configs = '/configs';
  static const calcs = '/calcs';
  static const answers = '/answers';

  static final pageList = [
    // GetPage(
    //   name: Routes.splash,
    //   binding: SplashDependencies(),
    //   page: () => const SplashPage(),
    // ),
    GetPage(
      name: Routes.configs,
      binding: ConfigsDependencies(),
      page: () => const ConfigsPage(),
    ),
    GetPage(
      name: Routes.calcs,
      binding: CalcsDependencies(),
      page: () => const CalcsPage(),
    ),
    GetPage(
      name: Routes.answers,
      binding: AnswersDependencies(),
      page: () => const AnswersPage(),
    ),
  ];
}
