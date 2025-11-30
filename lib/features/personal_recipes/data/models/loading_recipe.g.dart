// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadingRecipe _$LoadingRecipeFromJson(Map<String, dynamic> json) =>
    LoadingRecipe(
      recipeId: json['recipe_id'] as String,
      originalLink: json['original_link'] as String,
      timeStarted: json['time_started'] == null
          ? null
          : DateTime.parse(json['time_started'] as String),
      status:
          $enumDecodeNullable(_$LoadingStatusEnumMap, json['status']) ??
          LoadingStatus.processing,
    );

Map<String, dynamic> _$LoadingRecipeToJson(LoadingRecipe instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
      'original_link': instance.originalLink,
      'time_started': instance.timeStarted?.toIso8601String(),
      'status': _$LoadingStatusEnumMap[instance.status]!,
    };

const _$LoadingStatusEnumMap = {
  LoadingStatus.loading: 'loading',
  LoadingStatus.processing: 'processing',
  LoadingStatus.extractingTechniques: 'extracting_techniques',
  LoadingStatus.completed: 'completed',
  LoadingStatus.error: 'error',
};
