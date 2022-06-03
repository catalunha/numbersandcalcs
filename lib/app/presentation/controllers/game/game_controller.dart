import 'dart:async';
import 'dart:math';

import 'package:numbersandcalcs/app/presentation/controllers/game/game_exception.dart';
import 'package:numbersandcalcs/app/routes.dart';
import 'package:get/get.dart';

import 'package:numbersandcalcs/app/domain/utils/enums.dart';

class GameController extends GetxController {
  final _index = 0.obs;
  int get index => _index.value;
  set index(int value) => _index.value = value;

  var list1 = <int>[].obs;
  var list2 = <int>[].obs;
  var answers = <int>[].obs;
  var responses = <int?>[].obs;
  var response = ''.obs;

  final _errorMsg = ''.obs;
  final _errorCode = 1.obs;
  get errorMsg => _errorMsg.value;
  get errorCode => _errorCode.value;
  @override
  void onInit() {
    super.onInit();
    resetGame();
  }

  @override
  void onClose() {
    resetGame();
    super.onClose();
  }

  TypeOfOperations operationTypeCalc = TypeOfOperations.addition;

  var segCount = 0.obs;
  get timeCount =>
      '${minCount.value.toString().padLeft(2, '0')}:${segCount.value.toString().padLeft(2, '0')}';
  var minCount = 0.obs;

  Timer _timer = Timer(const Duration(seconds: 0), () {});
  void timerStart() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      segCount.value++;
      if (segCount > 60) {
        segCount(0);
        minCount(minCount.value + 1);
        if (minCount > 60) {
          segCount(0);
          minCount(0);
        }
      }
    });
  }

  void timerCancel() {
    _timer.cancel();
    // segCount(0);
    // minCount(0);
  }

  void resetGame() {
    _timer.cancel();
    segCount(0);
    minCount(0);
    response('');
    index = 0;
    list1.clear();
    list2.clear();
    answers.clear();
    responses.clear();
  }

  int numberOfCorrectAnswers() {
    int correct = 0;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i] == responses[i]) {
        correct++;
      }
    }
    return correct;
  }

  keyValue(String key) {
    response(response.value + key);
  }

  keyMinus(String key) {
    if (response.value.isEmpty) {
      response(response.value + key);
    }
  }

  keyBackspace() {
    if (response.value.isNotEmpty) {
      response(response.value.substring(0, response.value.length - 1));
    }
  }

  nextCalc() {
    if (responses.length < list1.length) {
      if (response.value.isNotEmpty && response.value != '-') {
        responses.add(int.parse(response.value));
      } else {
        responses.add(null);
      }
    }
    response.value = '';
    if (index < list1.length - 1) {
      index = index + 1;
    } else {
      timerCancel();
      Get.toNamed(Routes.answers);
    }
  }

  void startTraining({
    required int? amount,
    required TypeOfOperations operationType,
    required TypeOfNumbers list1Type,
    required int? num1Interval,
    required int? num1Start,
    required int? num1End,
    required TypeOfNumbers list2Type,
    required int? num2Interval,
    required int? num2Start,
    required int? num2End,
  }) {
    _errorCode(0);
    _errorMsg('Sem erro: Passou em todas as analises consideradas.');
    list1.clear();
    list2.clear();
    operationTypeCalc = operationType;
    try {
      if (amount == null) {
        throw GameException(
            code: 100, message: 'Erro : Informe a quantidade de operações.');
      }
      if (amount > 50) {
        throw GameException(
            code: 100, message: 'Erro : Limite atual é de 50 operações.');
      }
      if ([
        TypeOfOperations.addition,
        TypeOfOperations.subtraction,
        TypeOfOperations.multiplication,
        TypeOfOperations.division,
      ].contains(operationType)) {
        //+++ analise da lista 1
        if (list1Type == TypeOfNumbers.sequence) {
          if (num1Interval == null || num1Start == null) {
            throw GameException(
                code: 200,
                message: 'Erro : Na 1ª lista falta seguencia ou inicio.');
          }
        }

        if (list1Type == TypeOfNumbers.even ||
            list1Type == TypeOfNumbers.odd ||
            list1Type == TypeOfNumbers.prime) {
          if (num1Start == null) {
            throw GameException(
                code: 200, message: 'Erro : Na 1ª lista falta inicio.');
          }
        }

        if (list1Type == TypeOfNumbers.random) {
          if (num1Start == null || num1End == null) {
            throw GameException(
                code: 200, message: 'Erro : Na 1ª lista falta inicio ou fim.');
          }
          if (!(num1Start <= num1End)) {
            throw GameException(
                code: 200,
                message:
                    'Erro : Na 1ª lista o inicio deve ser menor ou igual que o fim.');
          }
          if ((num1End - num1Start + 1) < amount) {
            throw GameException(
                code: 200,
                message:
                    'Erro : Na 1ª lista a quantidade deve ser menor que (fim-inicio+1).');
          }
        }
        //+++ analise da lista 2
        if (list2Type == TypeOfNumbers.sequence) {
          if (num2Interval == null || num2Start == null) {
            throw GameException(
                code: 300,
                message: 'Erro : Na 2ª lista falta seguencia ou inicio.');
          }
        }
        if (list2Type == TypeOfNumbers.even ||
            list2Type == TypeOfNumbers.odd ||
            list2Type == TypeOfNumbers.prime) {
          if (num2Start == null) {
            throw GameException(
                code: 300, message: 'Erro : Na 2ª lista falta inicio.');
          }
        }
        if (list2Type == TypeOfNumbers.random) {
          if (num2Start == null || num2End == null) {
            throw GameException(
                code: 300, message: 'Erro : Na 2ª lista falta inicio ou fim.');
          }
          if (!(num2Start <= num2End)) {
            throw GameException(
                code: 300,
                message:
                    'Erro : Na 2ª lista o inicio deve ser menor ou igual que o fim.');
          }
          if ((num2End - num2Start + 1) < amount) {
            throw GameException(
                code: 300,
                message:
                    'Erro : Na 2ª lista a quantidade deve ser menor que (fim-inicio+1).');
          }
        }
      } else {
        if (num2Start == null) {
          throw GameException(
              code: 300,
              message: 'Erro : Você escolheu [**(>1),**(<1)] e um start nulo.');
        }
      }
      // +++ list1
      list1.clear();
      if (list1Type == TypeOfNumbers.sequence) {
        int value = num1Start!;
        do {
          list1.add(value);
          value = value + num1Interval!;
        } while (list1.length < amount);
      }
      if (list1Type == TypeOfNumbers.even) {
        int value = num1Start!;
        do {
          if (value % 2 == 0) {
            list1.add(value);
          }
          value++;
        } while (list1.length < amount);
      }
      if (list1Type == TypeOfNumbers.odd) {
        int value = num1Start!;
        do {
          if (value % 2 != 0) {
            list1.add(value);
          }
          value++;
        } while (list1.length < amount);
      }
      if (list1Type == TypeOfNumbers.prime) {
        int value = num1Start!;
        do {
          if (isPrime(value)) {
            list1.add(value);
          }
          value++;
        } while (list1.length < amount);
      }

      if (list1Type == TypeOfNumbers.random) {
        var numbers = <int>[];
        for (var i = num1Start!; i <= num1End!; i++) {
          numbers.add(i);
        }
        int randomIndex;
        do {
          // print(numbers);
          randomIndex = Random().nextInt(numbers.length);
          list1.add(numbers.elementAt(randomIndex));
          numbers.removeAt(randomIndex);
        } while (list1.length < amount);
      }

      // +++ list2
      list2.clear();
      if ([
        TypeOfOperations.addition,
        TypeOfOperations.subtraction,
        TypeOfOperations.multiplication,
        TypeOfOperations.division,
      ].contains(operationType)) {
        if (list2Type == TypeOfNumbers.sequence) {
          int value = num2Start!;
          do {
            list2.add(value);
            value = value + num2Interval!;
          } while (list2.length < amount);
        }
        if (list2Type == TypeOfNumbers.even) {
          int value = num2Start!;
          do {
            if (value % 2 == 0) {
              list2.add(value);
            }
            value++;
          } while (list2.length < amount);
        }
        if (list2Type == TypeOfNumbers.odd) {
          int value = num2Start!;
          do {
            if (value % 2 != 0) {
              list2.add(value);
            }
            value++;
          } while (list2.length < amount);
        }
        if (list2Type == TypeOfNumbers.prime) {
          int value = num2Start!;
          do {
            if (isPrime(value)) {
              list2.add(value);
            }
            value++;
          } while (list2.length < amount);
        }
        if (list2Type == TypeOfNumbers.random) {
          var numbers = <int>[];
          for (var i = num2Start!; i <= num2End!; i++) {
            numbers.add(i);
          }
          int randomIndex;
          do {
            // print(numbers);
            randomIndex = Random().nextInt(numbers.length);
            list2.add(numbers.elementAt(randomIndex));
            numbers.removeAt(randomIndex);
          } while (list2.length < amount);
        }
      } else {
        do {
          list2.add(num2Start!);
        } while (list2.length < amount);
      }
      if (list1.length != list2.length) {
        throw GameException(
            code: 400, message: 'Erro : Listas com tamanhos diferentes');
      }
      //+++ randomize lists
      list1.shuffle();
      list2.shuffle();

      //+++ calculus
      answers.clear();
      if (operationType == TypeOfOperations.addition) {
        for (var i = 0; i < list1.length; i++) {
          answers.add(list1[i] + list2[i]);
        }
      } else if (operationType == TypeOfOperations.subtraction) {
        for (var i = 0; i < list1.length; i++) {
          answers.add(list1[i] - list2[i]);
        }
      } else if (operationType == TypeOfOperations.multiplication) {
        for (var i = 0; i < list1.length; i++) {
          answers.add(list1[i] * list2[i]);
        }
      } else if (operationType == TypeOfOperations.division) {
        for (var i = 0; i < list1.length; i++) {
          answers.add(list1[i] ~/ list2[i]);
        }
      } else if (operationType == TypeOfOperations.exponents) {
        for (var i = 0; i < list1.length; i++) {
          answers.add(pow(list1[i], list2[i]).toInt());
        }
      } else if (operationType == TypeOfOperations.roots) {
        for (var i = 0; i < list1.length; i++) {
          answers.add(pow(list1[i], 1 / list2[i]).toInt());
        }
      }

      responses.clear();
      response.value = '';
      index = 0;
      timerStart();
      Get.toNamed(Routes.calcs);
    } on GameException catch (e) {
      _errorCode(e.code);
      _errorMsg(e.message);
    }
  }

  bool isPrime(int num) {
    for (var i = 2; i < num; i++) {
      if (num % i == 0) {
        return false;
      }
    }
    return num > 1;
  }
}
