import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

part 'recipe_status.g.dart';

/// Status of a single recipe in polling response.
@JsonSerializable()
class RecipeStatus extends Equatable {
  /// Current status of the recipe
  final LoadingStatus status;

  /// Recipe display data (only present when status is 'completed')
  final RecipeDisplayData? recipe;

  /// Error message (only present when status is 'error')
  @JsonKey(name: 'error_message')
  final String? errorMessage;

  const RecipeStatus({
    required this.status,
    this.recipe,
    this.errorMessage,
  });

  factory RecipeStatus.fromJson(Map<String, dynamic> json) =>
      _$RecipeStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeStatusToJson(this);

  @override
  List<Object?> get props => [status, recipe, errorMessage];
}
