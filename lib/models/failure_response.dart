enum MessageType { warning, error }

class FailureResponse {
  late MessageType type;
  late String content;

  FailureResponse({required this.type, required this.content});
}
