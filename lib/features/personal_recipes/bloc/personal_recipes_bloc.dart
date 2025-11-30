import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/app_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_event.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_state.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';
import 'package:squillo/features/personal_recipes/data/models/polling_request.dart';
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
  /// Optionally accepts [initialLoadingRecipes] to start with loading recipes.
  PersonalRecipesBloc({
    required this.repository,
    List<LoadingRecipe>? initialLoadingRecipes,
  }) : super(
         initialLoadingRecipes != null && initialLoadingRecipes.isNotEmpty
             ? PersonalRecipesLoaded(
                 recipes: const [],
                 filteredRecipes: const [],
                 searchQuery: '',
                 loadingRecipes: initialLoadingRecipes,
               )
             : const PersonalRecipesInitial(),
       ) {
    on<LoadRecipesRequested>(_onLoadRecipesRequested);
    on<SearchRecipesRequested>(_onSearchRecipesRequested);
    on<RefreshRecipesRequested>(_onRefreshRecipesRequested);
    on<PollLoadingRecipesRequested>(_onPollLoadingRecipesRequested);

    // Start polling if we have initial loading recipes
    if (initialLoadingRecipes != null && initialLoadingRecipes.isNotEmpty) {
      _startPolling();
    }
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
  /// Polls the server for updated loading recipe statuses using the dedicated
  /// polling endpoint. When a recipe completes, it's moved from loadingRecipes
  /// to the recipes list.
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
      // Use the polling endpoint with recipe IDs from loading recipes
      final recipeIds = currentState.loadingRecipes
          .map((recipe) => recipe.recipeId)
          .toList();

      final pollingRequest = PollingRequest(
        recipeIds: recipeIds,
        userId: AppConstants.kDefaultUserId,
      );

      final pollingResponse = await repository.pollRecipeStatus(pollingRequest);

      // Process polling response to update recipes and loading recipes
      final updatedRecipes = <RecipeDisplayData>[...currentState.recipes];
      final updatedLoadingRecipes = <LoadingRecipe>[];

      for (final entry in pollingResponse.statuses.entries) {
        final recipeId = entry.key;
        final recipeStatus = entry.value;

        if (recipeStatus.status == LoadingStatus.completed &&
            recipeStatus.recipe != null) {
          // Recipe completed - add to recipes list
          updatedRecipes.add(recipeStatus.recipe!);
        } else if (recipeStatus.status == LoadingStatus.error) {
          var alreadyHadErr = false;

          for (final x in currentState.loadingRecipes) {
            if (x.recipeId == recipeId) {
              alreadyHadErr = x.status == LoadingStatus.error;
              break;
            }
          }

          if (!alreadyHadErr) {
            final originalRecipe = currentState.loadingRecipes.firstWhere(
              (r) => r.recipeId == recipeId,
              orElse: () => LoadingRecipe(
                recipeId: recipeId,
                originalLink: '',
                status: recipeStatus.status,
              ),
            );

            updatedLoadingRecipes.add(
              LoadingRecipe(
                recipeId: recipeId,
                originalLink: originalRecipe.originalLink,
                status: recipeStatus.status,
              ),
            );
          }
        } else {
          // Recipe still loading or errored - keep in loading recipes
          final originalRecipe = currentState.loadingRecipes.firstWhere(
            (r) => r.recipeId == recipeId,
            orElse: () => LoadingRecipe(
              recipeId: recipeId,
              originalLink: '',
              status: recipeStatus.status,
            ),
          );
          updatedLoadingRecipes.add(
            LoadingRecipe(
              recipeId: recipeId,
              originalLink: originalRecipe.originalLink,
              status: recipeStatus.status,
            ),
          );
        }
      }

      // Sort recipes by created_at, newest first
      updatedRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Apply the current search filter to the updated recipes
      final filtered = currentState.searchQuery.isEmpty
          ? updatedRecipes
          : updatedRecipes
                .where(
                  (recipe) => recipe.recipeName.toLowerCase().contains(
                    currentState.searchQuery.toLowerCase(),
                  ),
                )
                .toList();

      emit(
        currentState.copyWith(
          recipes: updatedRecipes,
          filteredRecipes: filtered,
          loadingRecipes: updatedLoadingRecipes,
        ),
      );

      // Stop polling if no more loading recipes
      if (updatedLoadingRecipes.isEmpty) {
        _stopPolling();
      }

      // Log any errors for debugging
      final errorRecipes = updatedLoadingRecipes
          .where((recipe) => recipe.status == LoadingStatus.error)
          .toList();
      for (final errorRecipe in errorRecipes) {
        log(
          'Recipe import failed: ${errorRecipe.recipeId} from ${errorRecipe.originalLink}',
        );
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
