import 'package:squillo/features/import/data/datasources/import_remote_datasource.dart';
import 'package:squillo/features/import/data/models/import_request.dart';
import 'package:squillo/features/import/data/models/import_response.dart';

/// Repository for managing recipe imports.
class ImportRepository {
  final ImportRemoteDataSourceImpl remoteDataSource;

  /// Creates an [ImportRepository] with the given [remoteDataSource].
  ImportRepository({required this.remoteDataSource});

  /// Imports a recipe from a URL.
  ///
  /// Returns [ImportResponse] with recipe_id for polling.
  /// Throws exceptions from the data source (to be caught by Bloc).
  Future<ImportResponse> importRecipe(ImportRequest request) async {
    return await remoteDataSource.importRecipe(request);
  }
}
