// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_display_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDisplayData _$RecipeDisplayDataFromJson(Map<String, dynamic> json) =>
    RecipeDisplayData(
      recipeId: json['recipe_id'] as String,
      recipeName: json['recipe_name'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      difficulty: (json['difficulty'] as num).toInt(),
      techniqueIds:
          (json['technique_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RecipeDisplayDataToJson(RecipeDisplayData instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
      'recipe_name': instance.recipeName,
      'thumbnail_url': instance.thumbnailUrl,
      'difficulty': instance.difficulty,
      'technique_ids': instance.techniqueIds,
      'created_at': instance.createdAt.toIso8601String(),
    };
