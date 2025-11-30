import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

part 'import_response.g.dart';

/// Response model for recipe import (used by all platforms).
///
/// This model matches the OpenAPI ImportResponse schema.
@JsonSerializable()
class ImportResponse extends Equatable {
  /// Extracted recipe display data
  final RecipeDisplayData? recipe;

  /// Whether or not a recipe was found in the video
  @JsonKey(name: 'no_recipe_found', defaultValue: false)
  final bool noRecipeFound;

  /// Recipe ID for the imported recipe
  @JsonKey(name: 'recipe_id')
  final String recipeId;

  /// Creates an [ImportResponse] instance.
  const ImportResponse({
    this.recipe,
    this.noRecipeFound = false,
    required this.recipeId,
  });

  /// Creates an [ImportResponse] from JSON data.
  factory ImportResponse.fromJson(Map<String, dynamic> json) =>
      _$ImportResponseFromJson(json);

  /// Converts this [ImportResponse] to JSON.
  Map<String, dynamic> toJson() => _$ImportResponseToJson(this);

  @override
  List<Object?> get props => [recipe, noRecipeFound, recipeId];
}
