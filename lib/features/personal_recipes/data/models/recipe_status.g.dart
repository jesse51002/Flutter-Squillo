// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeStatus _$RecipeStatusFromJson(Map<String, dynamic> json) => RecipeStatus(
  status: $enumDecode(_$LoadingStatusEnumMap, json['status']),
  recipe: json['recipe'] == null
      ? null
      : RecipeDisplayData.fromJson(json['recipe'] as Map<String, dynamic>),
  errorMessage: json['error_message'] as String?,
);

Map<String, dynamic> _$RecipeStatusToJson(RecipeStatus instance) =>
    <String, dynamic>{
      'status': _$LoadingStatusEnumMap[instance.status]!,
      'recipe': instance.recipe,
      'error_message': instance.errorMessage,
    };

const _$LoadingStatusEnumMap = {
  LoadingStatus.loading: 'loading',
  LoadingStatus.processing: 'processing',
  LoadingStatus.extractingTechniques: 'extracting_techniques',
  LoadingStatus.completed: 'completed',
  LoadingStatus.error: 'error',
};
