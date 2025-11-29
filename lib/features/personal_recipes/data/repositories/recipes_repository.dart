import 'package:squillo/features/personal_recipes/data/datasources/recipes_remote_datasource.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';
import 'package:squillo/features/recipe_detail/data/models/stored_recipe.dart';
import 'package:squillo/features/recipe_detail/data/models/update_ingredient_checked_request.dart';
import 'package:squillo/features/recipe_detail/data/models/update_ingredient_checked_response.dart';

/// Repository for managing recipe data.
///
/// This is a concrete implementation (no abstract interface for MVP).
/// It handles fetching recipes from the remote data source and manages
/// any data transformations or caching (future enhancement).
class RecipesRepository {
  final RecipesRemoteDataSourceImpl remoteDataSource;

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

  /// Fetches a single recipe by [recipeId].
  ///
  /// Returns the complete [StoredRecipe] with all details.
  /// Throws exceptions from the data source (to be caught by Bloc).
  Future<StoredRecipe> getRecipeById(String recipeId) async {
    return await remoteDataSource.getRecipeById(recipeId);
  }

  /// Updates the checked status of an ingredient in a recipe.
  ///
  /// Returns [UpdateIngredientCheckedResponse] with the result.
  /// Throws exceptions from the data source (to be caught by Bloc).
  Future<UpdateIngredientCheckedResponse> updateIngredientChecked(
    UpdateIngredientCheckedRequest request,
  ) async {
    return await remoteDataSource.updateIngredientChecked(request);
  }
}
