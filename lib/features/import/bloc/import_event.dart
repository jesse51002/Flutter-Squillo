import 'package:equatable/equatable.dart';

/// Base class for all Import events.
sealed class ImportEvent extends Equatable {
  const ImportEvent();

  @override
  List<Object?> get props => [];
}

/// Event to import a recipe from a URL.
class ImportRecipeRequested extends ImportEvent {
  /// The URL to import the recipe from
  final String url;

  const ImportRecipeRequested(this.url);

  @override
  List<Object?> get props => [url];
}

/// Event to reset the import state.
class ImportResetRequested extends ImportEvent {
  const ImportResetRequested();
}
