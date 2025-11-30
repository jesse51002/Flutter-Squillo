import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/app_constants.dart';
import 'package:squillo/core/errors/exceptions.dart';
import 'package:squillo/features/import/bloc/import_event.dart';
import 'package:squillo/features/import/bloc/import_state.dart';
import 'package:squillo/features/import/data/models/import_request.dart';
import 'package:squillo/features/import/data/repositories/import_repository.dart';

/// Bloc for managing recipe import state.
///
/// Handles importing recipes from URLs and managing error states.
class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final ImportRepository repository;

  /// Creates an [ImportBloc] with the given [repository].
  ImportBloc({required this.repository}) : super(const ImportInitial()) {
    on<ImportRecipeRequested>(_onImportRecipeRequested);
    on<ImportResetRequested>(_onImportResetRequested);
  }

  /// Handles the [ImportRecipeRequested] event.
  Future<void> _onImportRecipeRequested(
    ImportRecipeRequested event,
    Emitter<ImportState> emit,
  ) async {
    emit(const ImportLoading());

    try {
      final request = ImportRequest(
        url: event.url,
        userId: AppConstants.kDefaultUserId,
        polling: true, // Use polling mode
      );

      final response = await repository.importRecipe(request);

      if (response.noRecipeFound) {
        emit(const ImportNoRecipeFound());
      } else {
        emit(ImportSuccess(response.recipeId));
      }
    } on NetworkException catch (e, stackTrace) {
      log('Network error importing recipe', error: e, stackTrace: stackTrace);
      emit(ImportError(e.message));
    } on ServerException catch (e, stackTrace) {
      log('Server error importing recipe', error: e, stackTrace: stackTrace);
      emit(ImportError(e.message));
    } catch (e, stackTrace) {
      log('Unexpected error importing recipe', error: e, stackTrace: stackTrace);
      emit(
        const ImportError(
          'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  /// Handles the [ImportResetRequested] event.
  void _onImportResetRequested(
    ImportResetRequested event,
    Emitter<ImportState> emit,
  ) {
    emit(const ImportInitial());
  }
}
