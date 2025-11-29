import 'package:equatable/equatable.dart';
import 'package:squillo/features/techniques/data/models/simplified_technique.dart';

/// Response schema for batch technique retrieval.
///
/// Based on the BatchTechniquesResponse schema from the OpenAPI specification.
class BatchTechniquesResponse extends Equatable {
  /// List of simplified techniques
  final List<SimplifiedTechnique> techniques;

  /// Creates a [BatchTechniquesResponse].
  const BatchTechniquesResponse({required this.techniques});

  /// Creates a [BatchTechniquesResponse] from JSON.
  factory BatchTechniquesResponse.fromJson(Map<String, dynamic> json) {
    return BatchTechniquesResponse(
      techniques: (json['techniques'] as List<dynamic>)
          .map((e) => SimplifiedTechnique.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Converts this [BatchTechniquesResponse] to JSON.
  Map<String, dynamic> toJson() {
    return {'techniques': techniques.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [techniques];
}
