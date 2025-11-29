import 'package:squillo/features/techniques/data/datasources/techniques_remote_datasource.dart';
import 'package:squillo/features/techniques/data/models/batch_techniques_request.dart';
import 'package:squillo/features/techniques/data/models/simplified_technique.dart';

/// Repository for managing technique data.
///
/// This is a concrete implementation (no abstract interface for MVP).
/// It handles fetching techniques from the remote data source.
class TechniquesRepository {
  final TechniquesRemoteDataSourceImpl remoteDataSource;

  /// Creates a [TechniquesRepository] with the given [remoteDataSource].
  TechniquesRepository({required this.remoteDataSource});

  /// Fetches multiple techniques by their IDs.
  ///
  /// Returns a list of [SimplifiedTechnique] objects.
  /// Throws exceptions from the data source (to be caught by Bloc).
  Future<List<SimplifiedTechnique>> getBatchTechniques(
    List<String> techniqueIds,
  ) async {
    if (techniqueIds.isEmpty) {
      return [];
    }

    final response = await remoteDataSource.getBatchTechniques(
      BatchTechniquesRequest(techniqueIds: techniqueIds),
    );

    return response.techniques;
  }
}
