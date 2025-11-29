// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_recipe_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtractionRecipeStep _$ExtractionRecipeStepFromJson(
  Map<String, dynamic> json,
) => ExtractionRecipeStep(
  stepNumber: json['step_number'] as String,
  instruction: json['instruction'] as String,
  techniques:
      (json['techniques'] as List<dynamic>?)
          ?.map(
            (e) => ExtractionTechniqueInfo.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  estimatedTime: (json['estimated_time'] as num).toDouble(),
  isActiveStep: json['is_active_step'] as bool,
);

Map<String, dynamic> _$ExtractionRecipeStepToJson(
  ExtractionRecipeStep instance,
) => <String, dynamic>{
  'step_number': instance.stepNumber,
  'instruction': instance.instruction,
  'techniques': instance.techniques,
  'estimated_time': instance.estimatedTime,
  'is_active_step': instance.isActiveStep,
};
