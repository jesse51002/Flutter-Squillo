// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polling_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollingRequest _$PollingRequestFromJson(Map<String, dynamic> json) =>
    PollingRequest(
      recipeIds: (json['recipe_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$PollingRequestToJson(PollingRequest instance) =>
    <String, dynamic>{
      'recipe_ids': instance.recipeIds,
      'user_id': instance.userId,
    };
