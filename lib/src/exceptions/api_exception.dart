class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  final Object? originalError;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
    this.originalError,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException($statusCode): $message';
    }

    return 'ApiException: $message';
  }
}