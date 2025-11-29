import 'package:equatable/equatable.dart';
import 'package:squillo/features/recipe_detail/data/models/extraction_ingredient.dart';

/// UI-only model that wraps an ingredient with its checkbox state.
///
/// This model is not persisted and is used only for managing ingredient
/// checkbox state in the recipe detail screen.
class IngredientWithState extends Equatable {
  /// The ingredient data
  final ExtractionIngredient ingredient;

  /// Whether the ingredient is checked off (optimistic UI state)
  final bool isChecked;

  /// Whether this ingredient is currently syncing with the server
  final bool isSyncing;

  /// Creates an [IngredientWithState] instance.
  const IngredientWithState({
    required this.ingredient,
    this.isChecked = false,
    this.isSyncing = false,
  });

  /// Creates a copy of this [IngredientWithState] with the given fields replaced.
  IngredientWithState copyWith({
    ExtractionIngredient? ingredient,
    bool? isChecked,
    bool? isSyncing,
  }) {
    return IngredientWithState(
      ingredient: ingredient ?? this.ingredient,
      isChecked: isChecked ?? this.isChecked,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }

  @override
  List<Object?> get props => [ingredient, isChecked, isSyncing];
}
