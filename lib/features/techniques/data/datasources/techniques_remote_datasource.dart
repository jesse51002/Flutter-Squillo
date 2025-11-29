import 'package:dio/dio.dart';
import 'package:squillo/core/constants/app_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/techniques/data/models/batch_techniques_request.dart';
import 'package:squillo/features/techniques/data/models/batch_techniques_response.dart';

/// Abstract interface for the techniques remote data source.
abstract class TechniquesRemoteDataSource {
  /// Fetches multiple techniques by their IDs.
  ///
  /// Throws [ServerException] if the server returns an error.
  /// Throws [NetworkException] if there's a network connectivity issue.
  Future<BatchTechniquesResponse> getBatchTechniques(
    BatchTechniquesRequest request,
  );
}

/// Implementation of [TechniquesRemoteDataSource] using Dio.
class TechniquesRemoteDataSourceImpl implements TechniquesRemoteDataSource {
  final Dio dio;

  /// Creates a [TechniquesRemoteDataSourceImpl] with the given [dio] client.
  TechniquesRemoteDataSourceImpl({required this.dio});

  @override
  Future<BatchTechniquesResponse> getBatchTechniques(
    BatchTechniquesRequest request,
  ) async {
    try {
      final response = await dio.post(
        '/v1/techniques/batch',
        data: request.toJson(),
        options: Options(receiveTimeout: AppConstants.kDefaultTimeout),
      );

      if (response.statusCode == 200) {
        return BatchTechniquesResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException(
          'Failed to fetch techniques',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const NetworkException(
          'Request timeout. Please check your connection.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException(
          'No internet connection. Please check your network.',
        );
      } else if (e.response != null) {
        throw ServerException(
          e.response?.data?['message'] ?? 'Server error occurred',
          e.response?.statusCode,
        );
      } else {
        throw NetworkException(e.message ?? 'Unknown network error');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
