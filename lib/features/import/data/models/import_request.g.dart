// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportRequest _$ImportRequestFromJson(Map<String, dynamic> json) =>
    ImportRequest(
      url: json['url'] as String,
      userId: json['user_id'] as String?,
      mock: json['mock'] as bool? ?? false,
      polling: json['polling'] as bool? ?? true,
    );

Map<String, dynamic> _$ImportRequestToJson(ImportRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'user_id': instance.userId,
      'mock': instance.mock,
      'polling': instance.polling,
    };
