import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigsPage extends StatefulWidget {
  const ConfigsPage({Key? key}) : super(key: key);

  @override
  State<ConfigsPage> createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  String number1Type = 'Sequence';
  String number2Type = 'Sequence';
  String operationType = 'Sum';
  bool intervalNum1 = false;
  bool intervalNum2 = false;
  List<String> typeOfNumbers = ['Sequence', 'Even', 'Odd', 'Prime', 'Random'];
  List<String> typeOfOperations = [
    'Sum',
    'Subtraction',
    'Multiplication',
    'Division',
    'Potency',
    'Squere root'
  ];
  final _intervalNum1TEC = TextEditingController();
  final _beginNum1TEC = TextEditingController();
  final _amountNum1TEC = TextEditingController();
  final _endNum1TEC = TextEditingController();

  final _intervalNum2TEC = TextEditingController();
  final _beginNum2TEC = TextEditingController();
  final _amountNum2TEC = TextEditingController();
  final _endNum2TEC = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configs')),
      body: SizedBox(
        width: 400,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dropNum1Type(
                  options: typeOfNumbers,
                  variable: number1Type,
                  faz: (value) {
                    number1Type = value;
                    if (value == 'Sequence') {
                      intervalNum1 = true;
                    } else {
                      intervalNum1 = false;
                    }
                  },
                ),
                input(
                    line1: 'interval',
                    controller: _intervalNum1TEC,
                    enabled: ['Sequence'].contains(number1Type)),
                input(line1: 'begin', controller: _beginNum1TEC),
                input(line1: 'amount', controller: _amountNum1TEC),
                input(
                    line1: 'end',
                    controller: _endNum1TEC,
                    enabled: ['Random'].contains(number1Type)),
              ],
            ),
            dropNum1Type(
              options: typeOfOperations,
              variable: operationType,
              faz: (value) {
                operationType = value;
                // if (value == 'Sequence') {
                //   intervalNum2 = true;
                // } else {
                //   intervalNum2 = false;
                // }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dropNum1Type(
                  options: typeOfNumbers,
                  variable: number2Type,
                  faz: (value) {
                    number2Type = value;
                    if (value == 'Sequence') {
                      intervalNum2 = true;
                    } else {
                      intervalNum2 = false;
                    }
                  },
                ),
                input(
                    line1: 'interval',
                    controller: _intervalNum2TEC,
                    enabled: ['Sequence'].contains(number2Type)),
                input(line1: 'begin', controller: _beginNum2TEC),
                input(line1: 'amount', controller: _amountNum2TEC),
                input(
                    line1: 'end',
                    controller: _endNum2TEC,
                    enabled: ['Random'].contains(number2Type)),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  print(number1Type);
                  print(intervalNum1);
                  print(_intervalNum1TEC.text);
                  print(_beginNum1TEC.text);
                  print(_amountNum1TEC.text);
                  print(_endNum1TEC.text);

                  print(number2Type);
                  print(operationType);

                  // print(intervalNum2);
                  // print(_intervalNum2TEC.text);
                  // print(_beginNum2TEC.text);
                  // print(_amountNum2TEC.text);
                  // print(_endNum2TEC.text);
                },
                child: const Text('Start Training'))
          ],
        )),
      ),
    );
  }

  SizedBox input(
      {bool enabled = true,
      required String line1,
      required TextEditingController controller}) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Text(line1),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
              // border: const OutlineInputBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: enabled ? null : const Icon(Icons.block),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
    );
  }

  Column dropNum1Type({
    required List<String> options,
    required String variable,
    required Function(String) faz,
  }) {
    return Column(
      children: [
        const Text('Type'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButton<String>(
            value: variable,
            icon: const Icon(Icons.arrow_downward),
            // elevation: 16,
            // style: const TextStyle(color: Colors.deepPurple),
            // underline: Container(
            //   height: 2,
            //   color: Colors.deepPurpleAccent,
            // ),
            // in: InputDecoration(
            //     // border: const OutlineInputBorder(),
            //     border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            onChanged: (String? newValue) {
              faz(newValue!);
              setState(() {});
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
