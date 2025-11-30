import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/app_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_event.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_state.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';
import 'package:squillo/features/personal_recipes/data/repositories/recipes_repository.dart';

/// Bloc for managing personal recipes state.
///
/// Handles loading recipes from the server, searching/filtering recipes,
/// polling for loading recipe updates, and managing error states.
class PersonalRecipesBloc
    extends Bloc<PersonalRecipesEvent, PersonalRecipesState> {
  final RecipesRepository repository;
  Timer? _pollingTimer;

  /// Creates a [PersonalRecipesBloc] with the given [repository].
  PersonalRecipesBloc({required this.repository})
      : super(const PersonalRecipesInitial()) {
    on<LoadRecipesRequested>(_onLoadRecipesRequested);
    on<SearchRecipesRequested>(_onSearchRecipesRequested);
    on<RefreshRecipesRequested>(_onRefreshRecipesRequested);
    on<PollLoadingRecipesRequested>(_onPollLoadingRecipesRequested);
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  /// Starts polling for loading recipe updates every 5 seconds.
  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => add(const PollLoadingRecipesRequested()),
    );
  }

  /// Stops polling for loading recipe updates.
  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Handles the [LoadRecipesRequested] event.
  Future<void> _onLoadRecipesRequested(
    LoadRecipesRequested event,
    Emitter<PersonalRecipesState> emit,
  ) async {
    emit(const PersonalRecipesLoading());

    try {
      final response = await repository.getUserRecipes(
        AppConstants.kDefaultUserId,
      );

      emit(
        PersonalRecipesLoaded(
          recipes: response.recipes,
          filteredRecipes: response.recipes,
          searchQuery: '',
          loadingRecipes: response.loadingRecipes,
        ),
      );

      // Start polling if there are loading recipes
      if (response.loadingRecipes.isNotEmpty) {
        _startPolling();
      } else {
        _stopPolling();
      }
    } on NetworkException catch (e, stackTrace) {
      log('Network error loading recipes', error: e, stackTrace: stackTrace);
      emit(PersonalRecipesError(e.message));
      _stopPolling();
    } on ServerException catch (e, stackTrace) {
      log('Server error loading recipes', error: e, stackTrace: stackTrace);
      emit(PersonalRecipesError(e.message));
      _stopPolling();
    } catch (e, stackTrace) {
      log('Unexpected error loading recipes', error: e, stackTrace: stackTrace);
      emit(
        const PersonalRecipesError(
          'An unexpected error occurred. Please try again.',
        ),
      );
      _stopPolling();
    }
  }

  /// Handles the [SearchRecipesRequested] event.
  void _onSearchRecipesRequested(
    SearchRecipesRequested event,
    Emitter<PersonalRecipesState> emit,
  ) {
    if (state is PersonalRecipesLoaded) {
      final currentState = state as PersonalRecipesLoaded;
      final query = event.query.toLowerCase().trim();

      if (query.isEmpty) {
        // No search query, show all recipes
        emit(
          currentState.copyWith(
            filteredRecipes: currentState.recipes,
            searchQuery: '',
          ),
        );
      } else {
        // Filter recipes by name
        final filtered = currentState.recipes
            .where((recipe) => recipe.recipeName.toLowerCase().contains(query))
            .toList();

        emit(
          currentState.copyWith(filteredRecipes: filtered, searchQuery: query),
        );
      }
    }
  }

  /// Handles the [RefreshRecipesRequested] event.
  Future<void> _onRefreshRecipesRequested(
    RefreshRecipesRequested event,
    Emitter<PersonalRecipesState> emit,
  ) async {
    // Keep the current state while refreshing (don't show loading)
    try {
      final response = await repository.getUserRecipes(
        AppConstants.kDefaultUserId,
      );

      emit(
        PersonalRecipesLoaded(
          recipes: response.recipes,
          filteredRecipes: response.recipes,
          searchQuery: '',
          loadingRecipes: response.loadingRecipes,
        ),
      );

      // Start or stop polling based on loading recipes
      if (response.loadingRecipes.isNotEmpty) {
        _startPolling();
      } else {
        _stopPolling();
      }
    } on NetworkException catch (e, stackTrace) {
      log('Network error refreshing recipes', error: e, stackTrace: stackTrace);
      emit(PersonalRecipesError(e.message));
      _stopPolling();
    } on ServerException catch (e, stackTrace) {
      log('Server error refreshing recipes', error: e, stackTrace: stackTrace);
      emit(PersonalRecipesError(e.message));
      _stopPolling();
    } catch (e, stackTrace) {
      log(
        'Unexpected error refreshing recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(
        const PersonalRecipesError(
          'An unexpected error occurred. Please try again.',
        ),
      );
      _stopPolling();
    }
  }

  /// Handles the [PollLoadingRecipesRequested] event.
  ///
  /// Polls the server for updated loading recipe statuses. When a recipe
  /// completes, it's moved from loadingRecipes to the recipes list.
  Future<void> _onPollLoadingRecipesRequested(
    PollLoadingRecipesRequested event,
    Emitter<PersonalRecipesState> emit,
  ) async {
    // Only poll if we're in a loaded state with loading recipes
    if (state is! PersonalRecipesLoaded) return;

    final currentState = state as PersonalRecipesLoaded;
    if (currentState.loadingRecipes.isEmpty) {
      _stopPolling();
      return;
    }

    try {
      final response = await repository.getUserRecipes(
        AppConstants.kDefaultUserId,
      );

      // Check if any loading recipes have errors
      final errorRecipes = response.loadingRecipes
          .where((recipe) => recipe.status == LoadingStatus.error)
          .toList();

      // Merge existing recipes with any newly completed ones
      final allRecipes = <RecipeDisplayData>[...response.recipes];

      // Apply the current search filter to the updated recipes
      final filtered = currentState.searchQuery.isEmpty
          ? allRecipes
          : allRecipes
              .where((recipe) => recipe.recipeName
                  .toLowerCase()
                  .contains(currentState.searchQuery.toLowerCase()))
              .toList();

      emit(
        currentState.copyWith(
          recipes: allRecipes,
          filteredRecipes: filtered,
          loadingRecipes: response.loadingRecipes,
        ),
      );

      // Stop polling if no more loading recipes
      if (response.loadingRecipes.isEmpty) {
        _stopPolling();
      }

      // Log any errors for debugging
      for (final errorRecipe in errorRecipes) {
        log('Recipe import failed: ${errorRecipe.recipeId} from ${errorRecipe.originalLink}');
      }
    } on NetworkException catch (e, stackTrace) {
      log(
        'Network error polling loading recipes',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't emit error state, just log it - polling will retry
    } on ServerException catch (e, stackTrace) {
      log(
        'Server error polling loading recipes',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't emit error state, just log it - polling will retry
    } catch (e, stackTrace) {
      log(
        'Unexpected error polling loading recipes',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't emit error state, just log it - polling will retry
    }
  }
}
