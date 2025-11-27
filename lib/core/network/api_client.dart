import 'package:dio/dio.dart';
import 'package:squillo/core/constants/api_constants.dart';
import 'package:squillo/core/constants/app_constants.dart';

/// API client for making HTTP requests.
///
/// This class configures and provides a Dio instance with appropriate
/// timeouts, interceptors, and error handling.
class ApiClient {
  late final Dio _dio;

  /// Gets the configured Dio instance
  Dio get dio => _dio;

  /// Creates an [ApiClient] and configures the Dio instance.
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: AppConstants.kDefaultTimeout,
        receiveTimeout: AppConstants.kDefaultTimeout,
        sendTimeout: AppConstants.kDefaultTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor for debugging
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (object) {
          // ignore: avoid_print
          print(object);
        },
      ),
    );
  }
}
