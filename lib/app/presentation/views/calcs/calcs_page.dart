import 'package:numbersandcalcs/app/presentation/controllers/game/game_controller.dart';
import 'package:numbersandcalcs/app/presentation/views/utils/app_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppAppbar(title: 'Solve'),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Obx(() => Text(widget.gameController.list1.toString())),
                // // const Text('2ª list:'),
                // Obx(() => Text(widget.gameController.list2.toString())),
                // // const Text('answers:'),
                // Obx(() => Text(widget.gameController.answers.toString())),
                // Obx(() => Text(widget.gameController.minCount.value
                //     .toString()
                //     .padLeft(2, '0'))),
                // Obx(() => Text(widget.gameController.timeCount)),
                // const Divider(),
                Obx(
                  () => Text(
                      '${widget.gameController.responses.length + 1} of ${widget.gameController.list1.length} questions. Total Time ${widget.gameController.timeCount}',
                      style: const TextStyle(fontSize: 20)),
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            '${widget.gameController.list1[widget.gameController.index]}',
                            style: const TextStyle(fontSize: 60),
                          )),
                      Text(
                        widget.gameController.operationTypeCalc.symbol,
                        style: const TextStyle(fontSize: 60),
                      ),
                      Obx(() => Text(
                            '${widget.gameController.list2[widget.gameController.index]}',
                            style: const TextStyle(fontSize: 60),
                          )),
                    ],
                  ),
                ),
                FittedBox(
                  child: Row(
                    children: [
                      Obx(() => Text(
                            ' ${widget.gameController.response} ',
                            style: const TextStyle(fontSize: 60),
                          )),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          keyBoard(
                              '7', () => widget.gameController.keyValue('7')),
                          keyBoard(
                              '8', () => widget.gameController.keyValue('8')),
                          keyBoard(
                              '9', () => widget.gameController.keyValue('9'))
                        ],
                      ),
                      // const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          keyBoard(
                              '4', () => widget.gameController.keyValue('4')),
                          keyBoard(
                              '5', () => widget.gameController.keyValue('5')),
                          keyBoard(
                              '6', () => widget.gameController.keyValue('6'))
                        ],
                      ),
                      // const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          keyBoard(
                              '1', () => widget.gameController.keyValue('1')),
                          keyBoard(
                              '2', () => widget.gameController.keyValue('2')),
                          keyBoard(
                              '3', () => widget.gameController.keyValue('3'))
                        ],
                      ),
                      // const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          keyBoard('<', () {
                            widget.gameController.keyBackspace();
                          }),
                          keyBoard(
                              '0', () => widget.gameController.keyValue('0')),
                          keyBoard('-', () {
                            widget.gameController.keyMinus('-');
                          })
                        ],
                      ),
                    ],
                  ),
                ),
                // const Divider(),

                SizedBox(
                  width: 250,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () => widget.gameController.nextCalc(),
                    child: Text(
                      'Next Question',
                      style: GoogleFonts.pacifico(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget keyBoard(String number, Function() tap) {
    return InkWell(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 90,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            number,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
