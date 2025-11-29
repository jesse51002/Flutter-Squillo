import 'package:equatable/equatable.dart';

/// Request schema for batch technique retrieval.
///
/// Based on the BatchTechniquesRequest schema from the OpenAPI specification.
class BatchTechniquesRequest extends Equatable {
  /// List of technique IDs to retrieve (minimum 1 required)
  final List<String> techniqueIds;

  /// Creates a [BatchTechniquesRequest].
  const BatchTechniquesRequest({required this.techniqueIds})
    : assert(techniqueIds.length > 0, 'At least one technique ID is required');

  /// Converts this [BatchTechniquesRequest] to JSON.
  Map<String, dynamic> toJson() {
    return {'technique_ids': techniqueIds};
  }

  @override
  List<Object?> get props => [techniqueIds];
}
