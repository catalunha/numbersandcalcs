enum TypeOfNumbers { sequence, even, odd, prime, random }

enum TypeOfOperations {
  addition,
  subtraction,
  multiplication,
  division,
  exponents,
  roots;

  String get symbol {
    switch (this) {
      case TypeOfOperations.addition:
        return '+';
      case TypeOfOperations.subtraction:
        return '-';
      case TypeOfOperations.multiplication:
        return '*';
      case TypeOfOperations.division:
        return '/';
      case TypeOfOperations.exponents:
        return '**';
      case TypeOfOperations.roots:
        return '~*';
      default:
        return '...';
    }
  }
}
