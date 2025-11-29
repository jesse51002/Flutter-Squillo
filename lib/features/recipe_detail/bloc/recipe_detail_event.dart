import 'package:equatable/equatable.dart';

/// Base class for all recipe detail events.
sealed class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load recipe details for a given recipe ID.
class LoadRecipeDetailRequested extends RecipeDetailEvent {
  /// The ID of the recipe to load
  final String recipeId;

  /// Creates a [LoadRecipeDetailRequested] event.
  const LoadRecipeDetailRequested(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

/// Event to toggle the checked state of an ingredient.
class ToggleIngredientChecked extends RecipeDetailEvent {
  /// The index of the ingredient in the ingredients list
  final int ingredientIndex;

  /// Creates a [ToggleIngredientChecked] event.
  const ToggleIngredientChecked(this.ingredientIndex);

  @override
  List<Object?> get props => [ingredientIndex];
}
