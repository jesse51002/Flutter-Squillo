import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_display_data.g.dart';

/// Lightweight recipe data model for displaying recipe summaries.
///
/// This model matches the OpenAPI RecipeDisplayData schema and is used
/// to display recipe cards in lists and grids.
@JsonSerializable()
class RecipeDisplayData extends Equatable {
  /// Unique identifier for the recipe
  @JsonKey(name: 'recipe_id')
  final String recipeId;

  /// Name of the recipe
  @JsonKey(name: 'recipe_name')
  final String recipeName;

  /// URL to the recipe thumbnail image (can be null)
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;

  /// Recipe difficulty level (1=easy, 2=medium, 3=complex)
  final int difficulty;

  /// List of technique IDs used in this recipe
  @JsonKey(name: 'technique_ids', defaultValue: [])
  final List<String> techniqueIds;

  /// Recipe creation timestamp
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Creates a [RecipeDisplayData] instance.
  const RecipeDisplayData({
    required this.recipeId,
    required this.recipeName,
    this.thumbnailUrl,
    required this.difficulty,
    required this.techniqueIds,
    required this.createdAt,
  });

  /// Creates a [RecipeDisplayData] from JSON data.
  factory RecipeDisplayData.fromJson(Map<String, dynamic> json) =>
      _$RecipeDisplayDataFromJson(json);

  /// Converts this [RecipeDisplayData] to JSON.
  Map<String, dynamic> toJson() => _$RecipeDisplayDataToJson(this);

  /// Creates a copy of this [RecipeDisplayData] with the given fields replaced.
  RecipeDisplayData copyWith({
    String? recipeId,
    String? recipeName,
    String? thumbnailUrl,
    int? difficulty,
    List<String>? techniqueIds,
    DateTime? createdAt,
  }) {
    return RecipeDisplayData(
      recipeId: recipeId ?? this.recipeId,
      recipeName: recipeName ?? this.recipeName,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      difficulty: difficulty ?? this.difficulty,
      techniqueIds: techniqueIds ?? this.techniqueIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        recipeId,
        recipeName,
        thumbnailUrl,
        difficulty,
        techniqueIds,
        createdAt,
      ];
}
