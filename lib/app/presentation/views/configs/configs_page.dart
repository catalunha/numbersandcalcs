import 'package:aluno/app/domain/utils/enums.dart';
import 'package:aluno/app/presentation/controllers/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConfigsPage extends StatefulWidget {
  GameController gameController = Get.find();
  ConfigsPage({Key? key}) : super(key: key);

  @override
  State<ConfigsPage> createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  TypeOfNumbers list1Type = TypeOfNumbers.sequence;
  TypeOfNumbers list2Type = TypeOfNumbers.sequence;
  TypeOfOperations operationType = TypeOfOperations.sum;

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
      appBar: AppBar(title: const Text('Numbers and Calcs')),
      body: SizedBox(
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
                  const Text('Math operations'),
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
                        input(title: 'amounts', controller: _amountTEC),
                        dropOperation(
                          title: 'type',
                          options: TypeOfOperations.values,
                          variable: operationType,
                          faz: (value) {
                            operationType = value;
                            _num2IntervalTEC.text = '';
                            _num2StartTEC.text = '';
                            // _num2AmountTEC.text = '';
                            _num2EndTEC.text = '';
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
                          title: 'type',
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
                        input(title: 'start', controller: _num1StartTEC),
                        input(
                          title: 'end',
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
                          title: 'type',
                          options: TypeOfNumbers.values,
                          variable: list2Type,
                          faz: (value) {
                            list2Type = value;
                            _num2IntervalTEC.text = '';
                            _num2StartTEC.text = '';
                            _num2EndTEC.text = '';
                          },
                          enabled: [
                            TypeOfOperations.sum,
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
                                  TypeOfOperations.sum,
                                  TypeOfOperations.subtraction,
                                  TypeOfOperations.multiplication,
                                  TypeOfOperations.division,
                                ].contains(operationType)),
                        input(title: 'start', controller: _num2StartTEC),
                        // input(
                        //     title: 'amount',
                        //     controller: _num2AmountTEC,
                        //     enabled: [
                        //       TypeOfOperations.sum,
                        //       TypeOfOperations.subtraction,
                        //       TypeOfOperations.multiplication,
                        //       TypeOfOperations.division,
                        //     ].contains(operationType)),
                        input(
                            title: 'end',
                            controller: _num2EndTEC,
                            enabled: TypeOfNumbers.random == list2Type &&
                                [
                                  TypeOfOperations.sum,
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
              child: const Text('Start Training'),
            ),
            const Text('Error:'),
            Obx(() => Text('${widget.gameController.errorCode}')),
            Obx(() => Text(widget.gameController.errorMsg)),
            const Text('1ª list:'),
            Obx(() => Text(widget.gameController.list1.toString())),
            const Text('2ª list:'),
            Obx(() => Text(widget.gameController.list2.toString())),
          ],
        )),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          enabled
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10.0),
                    enabled: enabled,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                )
              : const SizedBox(
                  width: 62,
                  height: 60,
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
                height: 48,
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
            : const SizedBox(width: 130, height: 48),
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
                height: 48,
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
