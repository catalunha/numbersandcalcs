import 'package:numbersandcalcs/app/domain/utils/enums.dart';
import 'package:numbersandcalcs/app/presentation/controllers/game/game_controller.dart';
import 'package:numbersandcalcs/app/presentation/views/utils/app_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbersandcalcs/app/presentation/views/utils/app_launch.dart';

class ConfigsPage extends StatefulWidget {
  GameController gameController = Get.find();
  ConfigsPage({Key? key}) : super(key: key);

  @override
  State<ConfigsPage> createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  TypeOfNumbers list1Type = TypeOfNumbers.sequence;
  TypeOfNumbers list2Type = TypeOfNumbers.sequence;
  TypeOfOperations operationType = TypeOfOperations.addition;

  final _amountTEC = TextEditingController();

  final _num1IntervalTEC = TextEditingController();
  final _num1StartTEC = TextEditingController();
  final _num1EndTEC = TextEditingController();

  final _num2IntervalTEC = TextEditingController();
  final _num2StartTEC = TextEditingController();
  final _num2EndTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: 'Numbers and Calcs'),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    const Text(
                      'Math operations',
                      // style: GoogleFonts.pacifico(
                      //     // fontSize: 12.0,
                      //     // color: Colors.black,
                      //     ),
                    ),
                    Obx(() => widget.gameController.errorCode == 100
                        ? Text(
                            widget.gameController.errorMsg,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox()),
                    Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          input(title: 'quantity', controller: _amountTEC),
                          dropOperation(
                            title: 'type',
                            options: TypeOfOperations.values,
                            variable: operationType,
                            faz: (value) {
                              operationType = value;
                              // _num2IntervalTEC.text = '';
                              // _num2StartTEC.text = '';
                              // // _num2AmountTEC.text = '';
                              // _num2EndTEC.text = '';
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10),
              Card(
                color: Colors.grey.shade100,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('First list of numbers'),
                    Obx(() => widget.gameController.errorCode == 200
                        ? Text(
                            widget.gameController.errorMsg,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox()),
                    Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dropNumberType(
                            title: 'number type',
                            options: TypeOfNumbers.values,
                            variable: list1Type,
                            faz: (value) {
                              list1Type = value;
                              _num1IntervalTEC.text = '';
                              _num1StartTEC.text = '';
                              _num1EndTEC.text = '';
                            },
                          ),
                          input(
                            title: 'interval',
                            controller: _num1IntervalTEC,
                            enabled: TypeOfNumbers.sequence == list1Type,
                          ),
                          input(title: 'start at', controller: _num1StartTEC),
                          input(
                            title: 'end at',
                            controller: _num1EndTEC,
                            enabled: TypeOfNumbers.random == list1Type,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    const Text('Second list of numbers'),
                    Obx(() => widget.gameController.errorCode == 300
                        ? Text(
                            widget.gameController.errorMsg,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox()),
                    Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dropNumberType(
                            title: 'number type',
                            options: TypeOfNumbers.values,
                            variable: list2Type,
                            faz: (value) {
                              list2Type = value;
                              _num2IntervalTEC.text = '';
                              _num2StartTEC.text = '';
                              _num2EndTEC.text = '';
                            },
                            enabled: [
                              TypeOfOperations.addition,
                              TypeOfOperations.subtraction,
                              TypeOfOperations.multiplication,
                              TypeOfOperations.division,
                            ].contains(operationType),
                          ),
                          input(
                              title: 'interval',
                              controller: _num2IntervalTEC,
                              enabled: TypeOfNumbers.sequence == list2Type &&
                                  [
                                    TypeOfOperations.addition,
                                    TypeOfOperations.subtraction,
                                    TypeOfOperations.multiplication,
                                    TypeOfOperations.division,
                                  ].contains(operationType)),
                          input(title: 'start at', controller: _num2StartTEC),
                          input(
                              title: 'end at',
                              controller: _num2EndTEC,
                              enabled: TypeOfNumbers.random == list2Type &&
                                  [
                                    TypeOfOperations.addition,
                                    TypeOfOperations.subtraction,
                                    TypeOfOperations.multiplication,
                                    TypeOfOperations.division,
                                  ].contains(operationType)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.gameController.startTraining(
                    amount: int.tryParse(_amountTEC.text),
                    operationType: operationType,
                    list1Type: list1Type,
                    num1Interval: int.tryParse(_num1IntervalTEC.text),
                    num1Start: int.tryParse(_num1StartTEC.text),
                    num1End: int.tryParse(_num1EndTEC.text),
                    list2Type: list2Type,
                    num2Interval: int.tryParse(_num2IntervalTEC.text),
                    num2Start: int.tryParse(_num2StartTEC.text),
                    num2End: int.tryParse(_num2EndTEC.text),
                  );
                },
                child: Text(
                  'Start Game',
                  style: GoogleFonts.pacifico(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Developed with ❤️ by brintec.org',
                style:
                    GoogleFonts.pacifico(fontSize: 12.0, color: Colors.black),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => AppLaunch.launchLink(
                        'https://numbersandcalcs.brintec.org/terms-of-use/'),
                    child: Text(
                      'Terms of use',
                      style: GoogleFonts.pacifico(fontSize: 10.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () => AppLaunch.launchLink(
                        'https://numbersandcalcs.brintec.org/privacy-policy/'),
                    child: Text(
                      'Privacy police',
                      style: GoogleFonts.pacifico(fontSize: 10.0),
                    ),
                  ),
                ],
              )
              // const Text('Error:'),
              // Obx(() => Text('${widget.gameController.errorCode}')),
              // Obx(() => Text(widget.gameController.errorMsg)),
              // const Text('1ª list:'),
              // Obx(() => Text(widget.gameController.list1.toString())),
              // // const Text('2ª list:'),
              // Obx(() => Text(widget.gameController.list2.toString())),
              // // const Text('answers:'),
              // Obx(() => Text(widget.gameController.answers.toString())),
            ],
          )),
        ),
      ),
    );
  }

  SizedBox input(
      {bool enabled = true,
      required String title,
      required TextEditingController controller}) {
    return SizedBox(
      width: 60,
      // height: 60,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          enabled
              ? SizedBox(
                  height: 30,
                  width: 50,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 10.0),
                      enabled: enabled,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 2),
                      prefixIcon: enabled
                          ? null
                          : const Icon(
                              Icons.block,
                              color: Colors.red,
                            ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                )
              : const SizedBox(
                  width: 60,
                  height: 30,
                ),
        ],
      ),
    );
  }

  Column dropNumberType({
    required String title,
    bool enabled = true,
    required List<TypeOfNumbers> options,
    required TypeOfNumbers variable,
    required Function(TypeOfNumbers) faz,
  }) {
    return Column(
      children: [
        Text(title),
        enabled
            ? Container(
                height: 30,
                width: 130,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: Center(
                  child: DropdownButton<TypeOfNumbers>(
                    value: variable,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (TypeOfNumbers? newValue) {
                      faz(newValue!);
                      setState(() {});
                    },
                    items: options.map<DropdownMenuItem<TypeOfNumbers>>(
                        (TypeOfNumbers value) {
                      return DropdownMenuItem<TypeOfNumbers>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox(width: 130, height: 30),
      ],
    );
  }

  Column dropOperation({
    required String title,
    bool enabled = true,
    required List<TypeOfOperations> options,
    required TypeOfOperations variable,
    required Function(TypeOfOperations) faz,
  }) {
    return Column(
      children: [
        Text(title),
        enabled
            ? Container(
                height: 30,
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: Center(
                  child: DropdownButton<TypeOfOperations>(
                    value: variable,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (TypeOfOperations? newValue) {
                      faz(newValue!);
                      setState(() {});
                    },
                    items: options.map<DropdownMenuItem<TypeOfOperations>>(
                        (TypeOfOperations value) {
                      return DropdownMenuItem<TypeOfOperations>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox(width: 50, height: 60),
      ],
    );
  }
}
