import 'package:aluno/app/presentation/controllers/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalcsPage extends StatefulWidget {
  GameController gameController = Get.find();

  CalcsPage({Key? key}) : super(key: key);

  @override
  State<CalcsPage> createState() => _CalcsPageState();
}

class _CalcsPageState extends State<CalcsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calcs')),
      body: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(widget.gameController.list1.toString())),
              // const Text('2ª list:'),
              Obx(() => Text(widget.gameController.list2.toString())),
              // const Text('answers:'),
              Obx(() => Text(widget.gameController.answers.toString())),
              Obx(() => Text(widget.gameController.responses.toString())),
              const Divider(),
              Obx(() => Text(
                  '${widget.gameController.responses.length} de ${widget.gameController.list1.length} operations')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Text(
                        '${widget.gameController.list1[widget.gameController.index]}',
                        style: const TextStyle(fontSize: 70),
                      )),
                  Text(
                    widget.gameController.operationTypeCalc.symbol,
                    style: const TextStyle(fontSize: 70),
                  ),
                  Obx(() => Text(
                        '${widget.gameController.list2[widget.gameController.index]}',
                        style: const TextStyle(fontSize: 70),
                      )),
                ],
              ),
              const Divider(),
              const Text('Resposta:'),
              Obx(() => Text(
                    '${widget.gameController.response}',
                    style: const TextStyle(fontSize: 50),
                  )),
              const Divider(),
              SizedBox(
                width: 250,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [keyBoard('7'), keyBoard('8'), keyBoard('9')],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [keyBoard('4'), keyBoard('5'), keyBoard('6')],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [keyBoard('1'), keyBoard('2'), keyBoard('3')],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [keyBoard('-'), keyBoard('0'), keyBoard('+')],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container keyBoard(String number) {
    return Container(
      width: 70,
      height: 70,
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        number,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}
