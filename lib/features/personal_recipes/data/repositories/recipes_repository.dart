import 'package:squillo/features/personal_recipes/data/datasources/recipes_remote_datasource.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

/// Repository for managing recipe data.
///
/// This is a concrete implementation (no abstract interface for MVP).
/// It handles fetching recipes from the remote data source and manages
/// any data transformations or caching (future enhancement).
class RecipesRepository {
  final RecipesRemoteDataSource remoteDataSource;

  /// Creates a [RecipesRepository] with the given [remoteDataSource].
  RecipesRepository({required this.remoteDataSource});

  /// Fetches all recipes for the given [userId].
  ///
  /// Returns a list of [RecipeDisplayData] sorted by creation date (newest first).
  /// Throws exceptions from the data source (to be caught by Bloc).
  Future<List<RecipeDisplayData>> getUserRecipes(String userId) async {
    final recipes = await remoteDataSource.getUserRecipes(userId);

    // Sort by created_at, newest first
    recipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return recipes;
  }
}
