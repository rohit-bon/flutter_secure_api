class ApiResponse<T> {
  final T? data;
  final int statusCode;
  final Map<String, dynamic> headers;

  const ApiResponse({
    required this.data,
    required this.statusCode,
    required this.headers,
  });

  bool get isSuccess =>
      statusCode >= 200 && statusCode < 300;
}