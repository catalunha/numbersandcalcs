import 'dart:math';

import 'package:aluno/app/presentation/controllers/game/game_exception.dart';
import 'package:get/get.dart';

import 'package:aluno/app/domain/utils/enums.dart';

class GameController extends GetxController {
  var list1 = <int>[].obs;
  var list2 = <int>[].obs;
  final _errorMsg = 'aaaa'.obs;
  final _errorCode = 1.obs;
  get errorMsg => _errorMsg.value;
  get errorCode => _errorCode.value;
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
    print('amount: $amount');
    print('operationType: $operationType');
    print('num1Type: $list1Type');
    print('num1Interval: $num1Interval');
    print('num1Start: $num1Start');
    print('num1End: $num1End');
    print('num2Type: $list2Type');
    print('num2Interval: $num2Interval');
    print('num2Start: $num2Start');
    print('num2End: $num2End');
    _errorCode(0);
    _errorMsg('Sem erro: Passou em todas as analises consideradas.');
    list1.clear();
    list2.clear();

    try {
      if (amount == null) {
        throw GameException(
            code: 100, message: 'Erro : Informe a quantidade de operações.');
      }
      if ([
        TypeOfOperations.sum,
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
      print('Sem erro. Gerar listas');

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
        TypeOfOperations.sum,
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
