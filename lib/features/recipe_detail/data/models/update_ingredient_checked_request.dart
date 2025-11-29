import 'package:equatable/equatable.dart';

/// Request schema for updating ingredient checked status.
///
/// Based on the UpdateIngredientCheckedRequest schema from the OpenAPI specification.
class UpdateIngredientCheckedRequest extends Equatable {
  /// Unique identifier for the recipe
  final String recipeId;

  /// ID of the user who owns the recipe
  final String userId;

  /// Name of the ingredient to update
  final String ingredientName;

  /// New checked status for the ingredient
  final bool checked;

  /// Creates an [UpdateIngredientCheckedRequest].
  const UpdateIngredientCheckedRequest({
    required this.recipeId,
    required this.userId,
    required this.ingredientName,
    required this.checked,
  });

  /// Converts this [UpdateIngredientCheckedRequest] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'recipe_id': recipeId,
      'user_id': userId,
      'ingredient_name': ingredientName,
      'checked': checked,
    };
  }

  @override
  List<Object?> get props => [recipeId, userId, ingredientName, checked];
}
