// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportResponse _$ImportResponseFromJson(Map<String, dynamic> json) =>
    ImportResponse(
      recipe: json['recipe'] == null
          ? null
          : RecipeDisplayData.fromJson(json['recipe'] as Map<String, dynamic>),
      noRecipeFound: json['no_recipe_found'] as bool? ?? false,
      recipeId: json['recipe_id'] as String,
    );

Map<String, dynamic> _$ImportResponseToJson(ImportResponse instance) =>
    <String, dynamic>{
      'recipe': instance.recipe,
      'no_recipe_found': instance.noRecipeFound,
      'recipe_id': instance.recipeId,
    };
