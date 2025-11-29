import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extraction_technique_info.g.dart';

/// Technique information extracted from a recipe step.
///
/// Contains technique metadata including importance and difficulty ratings.
@JsonSerializable()
class ExtractionTechniqueInfo extends Equatable {
  /// Unique identifier for the technique
  final String id;

  /// Name of the technique
  final String name;

  /// Importance rating (1-5)
  final int importance;

  /// Difficulty rating (1-5, defaults to 2)
  @JsonKey(defaultValue: 2)
  final int difficulty;

  /// Creates an [ExtractionTechniqueInfo] instance.
  const ExtractionTechniqueInfo({
    required this.id,
    required this.name,
    required this.importance,
    this.difficulty = 2,
  });

  /// Creates an [ExtractionTechniqueInfo] from JSON data.
  factory ExtractionTechniqueInfo.fromJson(Map<String, dynamic> json) =>
      _$ExtractionTechniqueInfoFromJson(json);

  /// Converts this [ExtractionTechniqueInfo] to JSON.
  Map<String, dynamic> toJson() => _$ExtractionTechniqueInfoToJson(this);

  /// Creates a copy of this [ExtractionTechniqueInfo] with the given fields replaced.
  ExtractionTechniqueInfo copyWith({
    String? id,
    String? name,
    int? importance,
    int? difficulty,
  }) {
    return ExtractionTechniqueInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      importance: importance ?? this.importance,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  List<Object?> get props => [id, name, importance, difficulty];
}
