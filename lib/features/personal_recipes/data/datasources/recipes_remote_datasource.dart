import 'package:dio/dio.dart';
import 'package:squillo/core/constants/api_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

/// Abstract interface for the recipes remote data source.
abstract class RecipesRemoteDataSource {
  /// Fetches all recipes for the given [userId].
  ///
  /// Throws [ServerException] if the server returns an error.
  /// Throws [NetworkException] if there's a network connectivity issue.
  Future<List<RecipeDisplayData>> getUserRecipes(String userId);
}

/// Implementation of [RecipesRemoteDataSource] using Dio.
class RecipesRemoteDataSourceImpl implements RecipesRemoteDataSource {
  final Dio dio;

  /// Creates a [RecipesRemoteDataSourceImpl] with the given [dio] client.
  RecipesRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<RecipeDisplayData>> getUserRecipes(String userId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.recipesEndpoint}/$userId/recipes',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map(
              (json) =>
                  RecipeDisplayData.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException('Failed to fetch recipes', response.statusCode);
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
