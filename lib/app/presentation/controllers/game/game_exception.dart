class GameException implements Exception {
  int code;
  String message;
  GameException({
    required this.code,
    required this.message,
  });
}
