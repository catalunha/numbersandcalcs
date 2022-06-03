import 'package:numbersandcalcs/app/presentation/controllers/game/game_controller.dart';
import 'package:numbersandcalcs/app/presentation/views/utils/app_appbar.dart';
import 'package:numbersandcalcs/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswersPage extends StatelessWidget {
  GameController gameController = Get.find();

  AnswersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: 'Your answers'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
                'Congrats. You got ${gameController.numberOfCorrectAnswers()} out of ${gameController.answers.length} questions correct.'),
            Text(
              'Total Time ${gameController.timeCount}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Table(
              border: TableBorder.all(),
              children: buildRow(),
            ),
            ElevatedButton(
                onPressed: () {
                  gameController.resetGame();
                  Get.offAllNamed(Routes.configs);
                },
                child: Text('Keep practicing...',
                    style: GoogleFonts.pacifico(
                      fontSize: 20.0,
                      color: Colors.white,
                    )))
          ],
        ),
      ),
    );
  }

  buildRow() {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      header('#'),
      header('1st'),
      header('Op.'),
      header('2nd'),
      header('='),
      header('Ans key'),
      // header('~'),
      header('Ans'),
      header('Status')
    ]));
    for (var i = 0; i < gameController.list1.length; i++) {
      bool correctLine =
          gameController.answers[i] == gameController.responses[i];
      rows.add(
        TableRow(
          decoration:
              BoxDecoration(color: correctLine ? Colors.white : Colors.yellow),
          children: [
            line(i + 1),
            line(gameController.list1[i].toString()),
            line(gameController.operationTypeCalc.symbol),
            line(gameController.list2[i].toString()),
            line('='),
            line(gameController.answers[i].toString()),
            // line('~'),
            line(gameController.responses[i]?.toString() ?? ''),
            gameController.answers[i] == gameController.responses[i]
                ? const Icon(Icons.check)
                : const Icon(
                    Icons.error_outline_sharp,
                    color: Colors.red,
                  )
          ],
        ),
      );
    }
    return rows;
  }

  Widget line(dynamic value) => Center(child: Text('$value'));

  Widget header(String value) {
    return Center(
      child: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
