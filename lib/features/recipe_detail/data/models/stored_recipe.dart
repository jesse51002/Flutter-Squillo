import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squillo/features/recipe_detail/data/models/extraction_ingredient.dart';
import 'package:squillo/features/recipe_detail/data/models/extraction_recipe_step.dart';

part 'stored_recipe.g.dart';

/// Complete recipe model with all details for the recipe detail screen.
///
/// This model matches the OpenAPI StoredRecipe schema and contains
/// comprehensive recipe information including ingredients, steps, and metadata.
@JsonSerializable()
class StoredRecipe extends Equatable {
  /// Unique identifier for the recipe
  @JsonKey(name: 'recipe_id')
  final String recipeId;

  /// ID of the user who owns this recipe
  @JsonKey(name: 'user_id')
  final String userId;

  /// Name of the recipe
  @JsonKey(name: 'recipe_name')
  final String recipeName;

  /// List of ingredients needed for the recipe
  final List<ExtractionIngredient> ingredients;

  /// List of recipe steps with techniques
  final List<ExtractionRecipeStep> steps;

  /// Recipe difficulty level (1=easy, 2=medium, 3=complex)
  final int difficulty;

  /// How many servings this recipe makes
  final int servings;

  /// Total active time for the recipe in minutes
  @JsonKey(name: 'active_time', defaultValue: 0.0)
  final double activeTime;

  /// Total time for the recipe in minutes
  @JsonKey(name: 'total_time', defaultValue: 0.0)
  final double totalTime;

  /// Original URL where the recipe was imported from (can be null)
  @JsonKey(name: 'source_url')
  final String? sourceUrl;

  /// URL to the recipe thumbnail image (can be null)
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;

  /// Recipe creation timestamp
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Creates a [StoredRecipe] instance.
  const StoredRecipe({
    required this.recipeId,
    required this.userId,
    required this.recipeName,
    required this.ingredients,
    required this.steps,
    required this.difficulty,
    required this.servings,
    this.activeTime = 0.0,
    this.totalTime = 0.0,
    this.sourceUrl,
    this.thumbnailUrl,
    required this.createdAt,
  });

  /// Creates a [StoredRecipe] from JSON data.
  factory StoredRecipe.fromJson(Map<String, dynamic> json) =>
      _$StoredRecipeFromJson(json);

  /// Converts this [StoredRecipe] to JSON.
  Map<String, dynamic> toJson() => _$StoredRecipeToJson(this);

  /// Creates a copy of this [StoredRecipe] with the given fields replaced.
  StoredRecipe copyWith({
    String? recipeId,
    String? userId,
    String? recipeName,
    List<ExtractionIngredient>? ingredients,
    List<ExtractionRecipeStep>? steps,
    int? difficulty,
    int? servings,
    double? activeTime,
    double? totalTime,
    String? sourceUrl,
    String? thumbnailUrl,
    DateTime? createdAt,
  }) {
    return StoredRecipe(
      recipeId: recipeId ?? this.recipeId,
      userId: userId ?? this.userId,
      recipeName: recipeName ?? this.recipeName,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      difficulty: difficulty ?? this.difficulty,
      servings: servings ?? this.servings,
      activeTime: activeTime ?? this.activeTime,
      totalTime: totalTime ?? this.totalTime,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    recipeId,
    userId,
    recipeName,
    ingredients,
    steps,
    difficulty,
    servings,
    activeTime,
    totalTime,
    sourceUrl,
    thumbnailUrl,
    createdAt,
  ];
}
