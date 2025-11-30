import 'package:dio/dio.dart';
import 'package:squillo/core/constants/app_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/import/data/models/import_request.dart';
import 'package:squillo/features/import/data/models/import_response.dart';

/// Abstract interface for the import remote data source.
abstract class ImportRemoteDataSource {
  /// Imports a recipe from a URL.
  ///
  /// Returns [ImportResponse] with recipe_id for polling.
  ///
  /// Throws [ServerException] if the server returns an error.
  /// Throws [NetworkException] if there's a network connectivity issue.
  Future<ImportResponse> importRecipe(ImportRequest request);
}

/// Implementation of [ImportRemoteDataSource] using Dio.
class ImportRemoteDataSourceImpl implements ImportRemoteDataSource {
  final Dio dio;

  /// Creates an [ImportRemoteDataSourceImpl] with the given [dio] client.
  ImportRemoteDataSourceImpl({required this.dio});

  @override
  Future<ImportResponse> importRecipe(ImportRequest request) async {
    try {
      final response = await dio.post(
        '/v1/import',
        data: request.toJson(),
        options: Options(receiveTimeout: AppConstants.kDefaultTimeout),
      );

      if (response.statusCode == 200) {
        return ImportResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException('Failed to import recipe', response.statusCode);
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
