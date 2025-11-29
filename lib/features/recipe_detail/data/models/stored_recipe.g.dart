// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredRecipe _$StoredRecipeFromJson(Map<String, dynamic> json) => StoredRecipe(
  recipeId: json['recipe_id'] as String,
  userId: json['user_id'] as String,
  recipeName: json['recipe_name'] as String,
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => ExtractionIngredient.fromJson(e as Map<String, dynamic>))
      .toList(),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => ExtractionRecipeStep.fromJson(e as Map<String, dynamic>))
      .toList(),
  difficulty: (json['difficulty'] as num).toInt(),
  servings: (json['servings'] as num).toInt(),
  activeTime: (json['active_time'] as num?)?.toDouble() ?? 0.0,
  totalTime: (json['total_time'] as num?)?.toDouble() ?? 0.0,
  sourceUrl: json['source_url'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$StoredRecipeToJson(StoredRecipe instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
      'user_id': instance.userId,
      'recipe_name': instance.recipeName,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'difficulty': instance.difficulty,
      'servings': instance.servings,
      'active_time': instance.activeTime,
      'total_time': instance.totalTime,
      'source_url': instance.sourceUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'created_at': instance.createdAt.toIso8601String(),
    };
