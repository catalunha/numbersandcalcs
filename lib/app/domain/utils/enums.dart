enum TypeOfNumbers { sequence, even, odd, prime, random }

enum TypeOfOperations {
  sum,
  subtraction,
  multiplication,
  division,
  potency,
  squareRoot;

  String get symbol {
    switch (this) {
      case TypeOfOperations.sum:
        return '+';
      case TypeOfOperations.subtraction:
        return '-';
      case TypeOfOperations.multiplication:
        return '*';
      case TypeOfOperations.division:
        return '/';
      case TypeOfOperations.potency:
        return '**';
      case TypeOfOperations.squareRoot:
        return '~*';
      default:
        return '...';
    }
  }
}
