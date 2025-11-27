import 'package:equatable/equatable.dart';

/// Base class for all PersonalRecipes events.
sealed class PersonalRecipesEvent extends Equatable {
  const PersonalRecipesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load recipes for the current user.
class LoadRecipesRequested extends PersonalRecipesEvent {
  const LoadRecipesRequested();
}

/// Event to search/filter recipes by query.
class SearchRecipesRequested extends PersonalRecipesEvent {
  /// Search query to filter recipes
  final String query;

  const SearchRecipesRequested(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event to refresh recipes from the server.
class RefreshRecipesRequested extends PersonalRecipesEvent {
  const RefreshRecipesRequested();
}
