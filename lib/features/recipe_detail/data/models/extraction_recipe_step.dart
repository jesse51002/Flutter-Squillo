import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squillo/features/recipe_detail/data/models/extraction_technique_info.dart';

part 'extraction_recipe_step.g.dart';

/// A single step in a recipe with associated cooking techniques.
@JsonSerializable()
class ExtractionRecipeStep extends Equatable {
  /// The sequential number of this step (supports decimals like "1.1", "1.2" for sub-steps)
  @JsonKey(name: 'step_number')
  final String stepNumber;

  /// The instruction text for this step
  final String instruction;

  /// List of cooking techniques used in this step with relevance and importance ratings
  @JsonKey(defaultValue: [])
  final List<ExtractionTechniqueInfo> techniques;

  /// The estimated amount of time the step will take in minutes (decimals allowed)
  @JsonKey(name: 'estimated_time')
  final double estimatedTime;

  /// Whether it is an active step (doing) or a passive step (waiting)
  @JsonKey(name: 'is_active_step')
  final bool isActiveStep;

  /// Creates an [ExtractionRecipeStep] instance.
  const ExtractionRecipeStep({
    required this.stepNumber,
    required this.instruction,
    this.techniques = const [],
    required this.estimatedTime,
    required this.isActiveStep,
  });

  /// Creates an [ExtractionRecipeStep] from JSON data.
  factory ExtractionRecipeStep.fromJson(Map<String, dynamic> json) =>
      _$ExtractionRecipeStepFromJson(json);

  /// Converts this [ExtractionRecipeStep] to JSON.
  Map<String, dynamic> toJson() => _$ExtractionRecipeStepToJson(this);

  /// Creates a copy of this [ExtractionRecipeStep] with the given fields replaced.
  ExtractionRecipeStep copyWith({
    String? stepNumber,
    String? instruction,
    List<ExtractionTechniqueInfo>? techniques,
    double? estimatedTime,
    bool? isActiveStep,
  }) {
    return ExtractionRecipeStep(
      stepNumber: stepNumber ?? this.stepNumber,
      instruction: instruction ?? this.instruction,
      techniques: techniques ?? this.techniques,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      isActiveStep: isActiveStep ?? this.isActiveStep,
    );
  }

  @override
  List<Object?> get props => [
    stepNumber,
    instruction,
    techniques,
    estimatedTime,
    isActiveStep,
  ];
}
