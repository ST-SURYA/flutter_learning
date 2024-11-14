import 'package:dio/dio.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:get/get.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com"));
  String? _accessToken;

  ApiService._internal() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // continue
        },
        onError: (DioException error, handler) {
          // Check if the error status code is 401 (Unauthorized)
          print("Unauthorized. Redirecting to login page.");
          if (error.response?.statusCode == 401) {
            Get.offAllNamed(Routes.login);
          }
          // Pass the error to the next handler
          return handler.next(error);
        },
      ),
    );
  }

  void setAccessToken(String token) {
    _accessToken = token;
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAccessToken() {
    _accessToken = null; // Clear the stored token
    dio.options.headers.remove('Authorization'); // Remove it from headers
    print("Access token cleared.");
  }
}
