import 'package:dio/dio.dart';

abstract class ApiInterceptor {
  void onRequest(RequestOptions options);

  void onResponse(Response response);

  void onError(DioException error);
}