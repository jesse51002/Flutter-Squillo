import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/app_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_event.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_state.dart';
import 'package:squillo/features/personal_recipes/data/repositories/recipes_repository.dart';

/// Bloc for managing personal recipes state.
///
/// Handles loading recipes from the server, searching/filtering recipes,
/// and managing error states.
class PersonalRecipesBloc
    extends Bloc<PersonalRecipesEvent, PersonalRecipesState> {
  final RecipesRepository repository;

  /// Creates a [PersonalRecipesBloc] with the given [repository].
  PersonalRecipesBloc({required this.repository})
      : super(const PersonalRecipesInitial()) {
    on<LoadRecipesRequested>(_onLoadRecipesRequested);
    on<SearchRecipesRequested>(_onSearchRecipesRequested);
    on<RefreshRecipesRequested>(_onRefreshRecipesRequested);
  }

  /// Handles the [LoadRecipesRequested] event.
  Future<void> _onLoadRecipesRequested(
    LoadRecipesRequested event,
    Emitter<PersonalRecipesState> emit,
  ) async {
    emit(const PersonalRecipesLoading());

    try {
      final recipes = await repository.getUserRecipes(
        AppConstants.kDefaultUserId,
      );

      emit(PersonalRecipesLoaded(
        recipes: recipes,
        filteredRecipes: recipes,
        searchQuery: '',
      ));
    } on NetworkException catch (e, stackTrace) {
      log(
        'Network error loading recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(PersonalRecipesError(e.message));
    } on ServerException catch (e, stackTrace) {
      log(
        'Server error loading recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(PersonalRecipesError(e.message));
    } catch (e, stackTrace) {
      log(
        'Unexpected error loading recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(const PersonalRecipesError(
        'An unexpected error occurred. Please try again.',
      ));
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
        emit(currentState.copyWith(
          filteredRecipes: currentState.recipes,
          searchQuery: '',
        ));
      } else {
        // Filter recipes by name
        final filtered = currentState.recipes
            .where((recipe) =>
                recipe.recipeName.toLowerCase().contains(query))
            .toList();

        emit(currentState.copyWith(
          filteredRecipes: filtered,
          searchQuery: query,
        ));
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
      final recipes = await repository.getUserRecipes(
        AppConstants.kDefaultUserId,
      );

      emit(PersonalRecipesLoaded(
        recipes: recipes,
        filteredRecipes: recipes,
        searchQuery: '',
      ));
    } on NetworkException catch (e, stackTrace) {
      log(
        'Network error refreshing recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(PersonalRecipesError(e.message));
    } on ServerException catch (e, stackTrace) {
      log(
        'Server error refreshing recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(PersonalRecipesError(e.message));
    } catch (e, stackTrace) {
      log(
        'Unexpected error refreshing recipes',
        error: e,
        stackTrace: stackTrace,
      );
      emit(const PersonalRecipesError(
        'An unexpected error occurred. Please try again.',
      ));
    }
  }
}
