// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtractionIngredient _$ExtractionIngredientFromJson(
  Map<String, dynamic> json,
) => ExtractionIngredient(
  name: json['name'] as String,
  quantity: json['quantity'] as String? ?? '',
  unit: json['unit'] as String? ?? '',
  checked: json['checked'] as bool? ?? false,
);

Map<String, dynamic> _$ExtractionIngredientToJson(
  ExtractionIngredient instance,
) => <String, dynamic>{
  'name': instance.name,
  'quantity': instance.quantity,
  'unit': instance.unit,
  'checked': instance.checked,
};
