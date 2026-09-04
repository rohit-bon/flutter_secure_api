import 'package:dio/dio.dart';

import '../auth/token_storage.dart';
import '../exceptions/api_exception.dart';
import '../models/api_response.dart';

class SecureApiClient {
  final Dio _dio;
  final TokenStorage tokenStorage;

  SecureApiClient({
    required String baseUrl,
    Dio? dio,
    TokenStorage? tokenStorage,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
  })  : tokenStorage = tokenStorage ?? TokenStorage(),
        _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: connectTimeout,
                receiveTimeout: receiveTimeout,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );
  }

  Future<void> setToken(String token) async {
    await tokenStorage.saveAccessToken(token);
  }

  Future<String?> getToken() async {
    return tokenStorage.getAccessToken();
  }

  Future<void> logout() async {
    await tokenStorage.clear();
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map,
      );
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map,
      );
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map,
      );
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map,
      );
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  ApiException _handleError(DioException error) {
    return ApiException(
      message: error.message ?? 'An unknown API error occurred.',
      statusCode: error.response?.statusCode,
      data: error.response?.data,
      originalError: error,
    );
  }
}