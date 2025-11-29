// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_technique_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtractionTechniqueInfo _$ExtractionTechniqueInfoFromJson(
  Map<String, dynamic> json,
) => ExtractionTechniqueInfo(
  id: json['id'] as String,
  name: json['name'] as String,
  importance: (json['importance'] as num).toInt(),
  difficulty: (json['difficulty'] as num?)?.toInt() ?? 2,
);

Map<String, dynamic> _$ExtractionTechniqueInfoToJson(
  ExtractionTechniqueInfo instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'importance': instance.importance,
  'difficulty': instance.difficulty,
};
