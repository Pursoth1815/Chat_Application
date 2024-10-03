class AuthResponse {
  final bool status;
  final String message;
  final dynamic responce;

  AuthResponse({
    required this.status,
    required this.message,
    this.responce,
  });
}
