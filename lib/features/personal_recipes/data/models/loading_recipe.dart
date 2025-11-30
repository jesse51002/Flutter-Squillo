import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loading_recipe.g.dart';

/// Status values for recipes being imported and polled.
enum LoadingStatus {
  @JsonValue('loading')
  loading,
  @JsonValue('processing')
  processing,
  @JsonValue('extracting_techniques')
  extractingTechniques,
  @JsonValue('completed')
  completed,
  @JsonValue('error')
  error,
}

/// Schema for tracking recipes currently being imported.
///
/// This model matches the OpenAPI LoadingRecipe schema and is used
/// to track the status of recipe imports.
@JsonSerializable()
class LoadingRecipe extends Equatable {
  /// Unique identifier for the recipe
  @JsonKey(name: 'recipe_id')
  final String recipeId;

  /// Original URL from which the recipe is being imported
  @JsonKey(name: 'original_link')
  final String originalLink;

  /// Timestamp when the import started
  @JsonKey(name: 'time_started')
  final DateTime? timeStarted;

  /// Current status of the import
  final LoadingStatus status;

  /// Creates a [LoadingRecipe] instance.
  const LoadingRecipe({
    required this.recipeId,
    required this.originalLink,
    this.timeStarted,
    this.status = LoadingStatus.processing,
  });

  /// Creates a [LoadingRecipe] from JSON data.
  factory LoadingRecipe.fromJson(Map<String, dynamic> json) =>
      _$LoadingRecipeFromJson(json);

  /// Converts this [LoadingRecipe] to JSON.
  Map<String, dynamic> toJson() => _$LoadingRecipeToJson(this);

  /// Creates a copy of this [LoadingRecipe] with the given fields replaced.
  LoadingRecipe copyWith({
    String? recipeId,
    String? originalLink,
    DateTime? timeStarted,
    LoadingStatus? status,
  }) {
    return LoadingRecipe(
      recipeId: recipeId ?? this.recipeId,
      originalLink: originalLink ?? this.originalLink,
      timeStarted: timeStarted ?? this.timeStarted,
      status: status ?? this.status,
    );
  }

  /// Extracts the base domain from the original link.
  ///
  /// For example, "https://www.tiktok.com/..." returns "tiktok"
  String get baseSite {
    try {
      final uri = Uri.parse(originalLink);
      final host = uri.host.toLowerCase();

      // Remove www. prefix if present
      final withoutWww = host.startsWith('www.') ? host.substring(4) : host;

      // Extract domain name (e.g., "tiktok.com" -> "tiktok")
      final parts = withoutWww.split('.');
      return parts.isNotEmpty ? parts[0] : withoutWww;
    } catch (e) {
      return 'unknown';
    }
  }

  /// Returns a user-friendly display text for the current status.
  String get statusDisplayText {
    switch (status) {
      case LoadingStatus.loading:
        return 'Loading...';
      case LoadingStatus.processing:
        return 'Processing...';
      case LoadingStatus.extractingTechniques:
        return 'Extracting techniques...';
      case LoadingStatus.completed:
        return 'Completed';
      case LoadingStatus.error:
        return 'Failed import';
    }
  }

  @override
  List<Object?> get props => [
        recipeId,
        originalLink,
        timeStarted,
        status,
      ];
}
