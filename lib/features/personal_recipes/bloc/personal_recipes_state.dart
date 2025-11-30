import 'package:equatable/equatable.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

/// Base class for all PersonalRecipes states.
sealed class PersonalRecipesState extends Equatable {
  const PersonalRecipesState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any recipes are loaded.
class PersonalRecipesInitial extends PersonalRecipesState {
  const PersonalRecipesInitial();
}

/// State when recipes are being loaded from the server.
class PersonalRecipesLoading extends PersonalRecipesState {
  const PersonalRecipesLoading();
}

/// State when recipes have been successfully loaded.
class PersonalRecipesLoaded extends PersonalRecipesState {
  /// All completed recipes from the server
  final List<RecipeDisplayData> recipes;

  /// Filtered recipes based on search query
  final List<RecipeDisplayData> filteredRecipes;

  /// Current search query
  final String searchQuery;

  /// Recipes currently being imported
  final List<LoadingRecipe> loadingRecipes;

  const PersonalRecipesLoaded({
    required this.recipes,
    required this.filteredRecipes,
    required this.searchQuery,
    this.loadingRecipes = const [],
  });

  @override
  List<Object?> get props => [
        recipes,
        filteredRecipes,
        searchQuery,
        loadingRecipes,
      ];

  /// Returns true if there are any recipes currently being imported.
  bool get hasLoadingRecipes => loadingRecipes.isNotEmpty;

  /// Creates a copy of this state with optional field updates.
  PersonalRecipesLoaded copyWith({
    List<RecipeDisplayData>? recipes,
    List<RecipeDisplayData>? filteredRecipes,
    String? searchQuery,
    List<LoadingRecipe>? loadingRecipes,
  }) {
    return PersonalRecipesLoaded(
      recipes: recipes ?? this.recipes,
      filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      searchQuery: searchQuery ?? this.searchQuery,
      loadingRecipes: loadingRecipes ?? this.loadingRecipes,
    );
  }
}

/// State when an error occurs while loading recipes.
class PersonalRecipesError extends PersonalRecipesState {
  /// Error message to display to the user
  final String message;

  const PersonalRecipesError(this.message);

  @override
  List<Object?> get props => [message];
}
