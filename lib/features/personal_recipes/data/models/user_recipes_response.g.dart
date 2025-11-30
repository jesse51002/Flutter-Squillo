// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recipes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecipesResponse _$UserRecipesResponseFromJson(Map<String, dynamic> json) =>
    UserRecipesResponse(
      recipes: (json['recipes'] as List<dynamic>)
          .map((e) => RecipeDisplayData.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingRecipes:
          (json['loading_recipes'] as List<dynamic>?)
              ?.map((e) => LoadingRecipe.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserRecipesResponseToJson(
  UserRecipesResponse instance,
) => <String, dynamic>{
  'recipes': instance.recipes,
  'loading_recipes': instance.loadingRecipes,
};
