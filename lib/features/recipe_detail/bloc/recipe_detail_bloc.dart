import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/personal_recipes/data/repositories/recipes_repository.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:squillo/features/recipe_detail/data/models/ingredient_with_state.dart';
import 'package:squillo/features/recipe_detail/data/models/update_ingredient_checked_request.dart';
import 'package:squillo/features/techniques/data/models/simplified_technique.dart';
import 'package:squillo/features/techniques/data/repositories/techniques_repository.dart';

/// Bloc for managing recipe detail screen state.
///
/// Handles loading a single recipe's complete details, managing ingredient
/// checkbox states, and error handling.
class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final RecipesRepository repository;
  final TechniquesRepository techniquesRepository;

  /// Creates a [RecipeDetailBloc] with the given [repository] and [techniquesRepository].
  RecipeDetailBloc({
    required this.repository,
    required this.techniquesRepository,
  }) : super(const RecipeDetailInitial()) {
    on<LoadRecipeDetailRequested>(_onLoadRecipeDetailRequested);
    on<ToggleIngredientChecked>(_onToggleIngredientChecked);
  }

  /// Handles the [LoadRecipeDetailRequested] event.
  Future<void> _onLoadRecipeDetailRequested(
    LoadRecipeDetailRequested event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(const RecipeDetailLoading());

    try {
      final recipe = await repository.getRecipeById(event.recipeId);

      // Initialize all ingredients with their checked state from server
      final ingredientsWithState = recipe.ingredients
          .map(
            (ingredient) => IngredientWithState(
              ingredient: ingredient,
              isChecked: ingredient.checked,
            ),
          )
          .toList();

      // Extract unique technique IDs from recipe steps
      final uniqueTechniqueIds = <String>{};
      for (final step in recipe.steps) {
        for (final technique in step.techniques) {
          uniqueTechniqueIds.add(technique.id);
        }
      }

      // Fetch full technique details if there are any techniques
      final simplifiedTechniques = uniqueTechniqueIds.isNotEmpty
          ? await techniquesRepository.getBatchTechniques(
              uniqueTechniqueIds.toList(),
            )
          : <SimplifiedTechnique>[];

      emit(
        RecipeDetailLoaded(
          recipe: recipe,
          ingredientsWithState: ingredientsWithState,
          currentServingCount: recipe.servings,
          simplifiedTechniques: simplifiedTechniques,
        ),
      );
    } on NetworkException catch (e, stackTrace) {
      log(
        'Network error loading recipe detail',
        error: e,
        stackTrace: stackTrace,
      );
      emit(RecipeDetailError(e.message));
    } on ServerException catch (e, stackTrace) {
      log(
        'Server error loading recipe detail',
        error: e,
        stackTrace: stackTrace,
      );
      emit(RecipeDetailError(e.message));
    } catch (e, stackTrace) {
      log(
        'Unexpected error loading recipe detail',
        error: e,
        stackTrace: stackTrace,
      );
      emit(
        const RecipeDetailError(
          'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  /// Handles the [ToggleIngredientChecked] event.
  ///
  /// Implements optimistic UI updates with server synchronization:
  /// 1. Immediately update UI state (optimistic)
  /// 2. Mark ingredient as syncing to disable checkbox
  /// 3. Send request to server
  /// 4. On success: clear syncing flag
  /// 5. On error: revert to previous state and clear syncing flag
  Future<void> _onToggleIngredientChecked(
    ToggleIngredientChecked event,
    Emitter<RecipeDetailState> emit,
  ) async {
    if (state is! RecipeDetailLoaded) return;

    final currentState = state as RecipeDetailLoaded;
    final ingredient = currentState.ingredientsWithState[event.ingredientIndex];

    // Don't allow toggling if already syncing
    if (ingredient.isSyncing) return;

    final newCheckedValue = !ingredient.isChecked;

    // Step 1: Optimistic UI update + mark as syncing
    final updatedIngredients = List<IngredientWithState>.from(
      currentState.ingredientsWithState,
    );
    updatedIngredients[event.ingredientIndex] = ingredient.copyWith(
      isChecked: newCheckedValue,
      isSyncing: true,
    );
    emit(currentState.copyWith(ingredientsWithState: updatedIngredients));

    // Step 2: Sync with server
    try {
      final request = UpdateIngredientCheckedRequest(
        recipeId: currentState.recipe.recipeId,
        userId: currentState.recipe.userId,
        ingredientName: ingredient.ingredient.name,
        checked: newCheckedValue,
      );

      await repository.updateIngredientChecked(request);

      // Step 3: Success - clear syncing flag
      if (state is RecipeDetailLoaded) {
        final latestState = state as RecipeDetailLoaded;
        final latestIngredients = List<IngredientWithState>.from(
          latestState.ingredientsWithState,
        );
        latestIngredients[event.ingredientIndex] =
            latestIngredients[event.ingredientIndex].copyWith(isSyncing: false);
        emit(latestState.copyWith(ingredientsWithState: latestIngredients));
      }
    } on NetworkException catch (e, stackTrace) {
      log(
        'Network error updating ingredient checked status',
        error: e,
        stackTrace: stackTrace,
      );
      _revertIngredientState(event.ingredientIndex, ingredient, emit);
    } on ServerException catch (e, stackTrace) {
      log(
        'Server error updating ingredient checked status',
        error: e,
        stackTrace: stackTrace,
      );
      _revertIngredientState(event.ingredientIndex, ingredient, emit);
    } catch (e, stackTrace) {
      log(
        'Unexpected error updating ingredient checked status',
        error: e,
        stackTrace: stackTrace,
      );
      _revertIngredientState(event.ingredientIndex, ingredient, emit);
    }
  }

  /// Reverts ingredient state to original on sync failure.
  void _revertIngredientState(
    int index,
    IngredientWithState originalIngredient,
    Emitter<RecipeDetailState> emit,
  ) {
    if (state is RecipeDetailLoaded) {
      final currentState = state as RecipeDetailLoaded;
      final revertedIngredients = List<IngredientWithState>.from(
        currentState.ingredientsWithState,
      );
      revertedIngredients[index] = originalIngredient.copyWith(
        isSyncing: false,
      );
      emit(currentState.copyWith(ingredientsWithState: revertedIngredients));
    }
  }
}
