// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polling_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollingResponse _$PollingResponseFromJson(Map<String, dynamic> json) =>
    PollingResponse(
      statuses: (json['statuses'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, RecipeStatus.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$PollingResponseToJson(PollingResponse instance) =>
    <String, dynamic>{'statuses': instance.statuses};
