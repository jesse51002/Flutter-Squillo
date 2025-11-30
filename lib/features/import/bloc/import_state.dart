import 'package:equatable/equatable.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';

/// Base class for all Import states.
sealed class ImportState extends Equatable {
  const ImportState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any import is attempted.
class ImportInitial extends ImportState {
  const ImportInitial();
}

/// State when a recipe is being imported.
class ImportLoading extends ImportState {
  const ImportLoading();
}

/// State when a recipe has been successfully imported.
class ImportSuccess extends ImportState {
  /// The recipe ID that was imported
  final String recipeId;

  /// The loading recipe to track import status
  final LoadingRecipe loadingRecipe;

  const ImportSuccess(this.recipeId, this.loadingRecipe);

  @override
  List<Object?> get props => [recipeId, loadingRecipe];
}

/// State when no recipe was found at the provided URL.
class ImportNoRecipeFound extends ImportState {
  const ImportNoRecipeFound();
}

/// State when an error occurs during import.
class ImportError extends ImportState {
  /// Error message to display to the user
  final String message;

  const ImportError(this.message);

  @override
  List<Object?> get props => [message];
}
