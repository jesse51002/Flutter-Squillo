import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

part 'user_recipes_response.g.dart';

/// Response schema for getting all recipes for a user.
///
/// Contains both completed recipes and recipes currently being loaded.
/// This model matches the OpenAPI UserRecipesResponse schema.
@JsonSerializable()
class UserRecipesResponse extends Equatable {
  /// List of completed recipes owned by the user
  final List<RecipeDisplayData> recipes;

  /// List of recipes currently being imported
  @JsonKey(name: 'loading_recipes', defaultValue: [])
  final List<LoadingRecipe> loadingRecipes;

  /// Creates a [UserRecipesResponse] instance.
  const UserRecipesResponse({
    required this.recipes,
    this.loadingRecipes = const [],
  });

  /// Creates a [UserRecipesResponse] from JSON data.
  factory UserRecipesResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRecipesResponseFromJson(json);

  /// Converts this [UserRecipesResponse] to JSON.
  Map<String, dynamic> toJson() => _$UserRecipesResponseToJson(this);

  /// Creates a copy of this [UserRecipesResponse] with the given fields replaced.
  UserRecipesResponse copyWith({
    List<RecipeDisplayData>? recipes,
    List<LoadingRecipe>? loadingRecipes,
  }) {
    return UserRecipesResponse(
      recipes: recipes ?? this.recipes,
      loadingRecipes: loadingRecipes ?? this.loadingRecipes,
    );
  }

  /// Returns true if there are any recipes currently being imported.
  bool get hasLoadingRecipes => loadingRecipes.isNotEmpty;

  @override
  List<Object?> get props => [recipes, loadingRecipes];
}
