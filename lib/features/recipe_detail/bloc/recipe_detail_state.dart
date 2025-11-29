import 'package:equatable/equatable.dart';
import 'package:squillo/features/recipe_detail/data/models/extraction_technique_info.dart';
import 'package:squillo/features/recipe_detail/data/models/ingredient_with_state.dart';
import 'package:squillo/features/recipe_detail/data/models/stored_recipe.dart';
import 'package:squillo/features/techniques/data/models/simplified_technique.dart';

/// Base class for all recipe detail states.
sealed class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any recipe is loaded.
class RecipeDetailInitial extends RecipeDetailState {
  /// Creates a [RecipeDetailInitial] state.
  const RecipeDetailInitial();
}

/// State while recipe details are being loaded from the server.
class RecipeDetailLoading extends RecipeDetailState {
  /// Creates a [RecipeDetailLoading] state.
  const RecipeDetailLoading();
}

/// State when recipe details have been successfully loaded.
class RecipeDetailLoaded extends RecipeDetailState {
  /// The complete recipe data
  final StoredRecipe recipe;

  /// List of ingredients with their checkbox states
  final List<IngredientWithState> ingredientsWithState;

  /// Current serving count (for future serving adjustment feature)
  final int currentServingCount;

  /// List of simplified techniques with full details (images, colors, etc.)
  final List<SimplifiedTechnique> simplifiedTechniques;

  /// Creates a [RecipeDetailLoaded] state.
  const RecipeDetailLoaded({
    required this.recipe,
    required this.ingredientsWithState,
    required this.currentServingCount,
    this.simplifiedTechniques = const [],
  });

  /// Returns unique techniques across all recipe steps.
  List<ExtractionTechniqueInfo> get uniqueTechniques {
    final Map<String, ExtractionTechniqueInfo> map = {};
    for (final step in recipe.steps) {
      for (final technique in step.techniques) {
        map.putIfAbsent(technique.id, () => technique);
      }
    }
    return map.values.toList();
  }

  /// Returns the count of unique techniques.
  int get techniqueCount => uniqueTechniques.length;

  /// Creates a copy of this state with the given fields replaced.
  RecipeDetailLoaded copyWith({
    StoredRecipe? recipe,
    List<IngredientWithState>? ingredientsWithState,
    int? currentServingCount,
    List<SimplifiedTechnique>? simplifiedTechniques,
  }) {
    return RecipeDetailLoaded(
      recipe: recipe ?? this.recipe,
      ingredientsWithState: ingredientsWithState ?? this.ingredientsWithState,
      currentServingCount: currentServingCount ?? this.currentServingCount,
      simplifiedTechniques: simplifiedTechniques ?? this.simplifiedTechniques,
    );
  }

  @override
  List<Object?> get props => [
    recipe,
    ingredientsWithState,
    currentServingCount,
    simplifiedTechniques,
  ];
}

/// State when an error occurs loading recipe details.
class RecipeDetailError extends RecipeDetailState {
  /// The error message to display
  final String message;

  /// Creates a [RecipeDetailError] state.
  const RecipeDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
