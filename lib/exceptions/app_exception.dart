/// Base class for all exceptions thrown by the app.
sealed class AppException implements Exception {
  AppException(this.code, this.message);

  /// A code that represents the exception.
  final String code;

  /// A message that describes the exception.
  final String message;

  @override
  String toString() => message;
}

/// Exception thrown when an unknown error occurs.
class UnknownException extends AppException {
  /// Creates a new instance of the [UnknownException] class.
  UnknownException([String? detail])
    : super(
        'unknown_error',
        detail ?? 'Une erreur est survenue. Veuillez réessayer.',
      );
}
