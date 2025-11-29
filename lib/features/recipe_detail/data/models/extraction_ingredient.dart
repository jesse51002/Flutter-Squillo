import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extraction_ingredient.g.dart';

/// A single ingredient with quantity and unit.
@JsonSerializable()
class ExtractionIngredient extends Equatable {
  /// Name of the ingredient
  final String name;

  /// Quantity as a string (e.g., "2", "1/2", empty if not specified)
  @JsonKey(defaultValue: '')
  final String quantity;

  /// Unit of measurement (e.g., 'cups', 'tablespoons', 'grams', empty if not specified)
  @JsonKey(defaultValue: '')
  final String unit;

  /// Whether the ingredient has been checked off
  @JsonKey(defaultValue: false)
  final bool checked;

  /// Creates an [ExtractionIngredient] instance.
  const ExtractionIngredient({
    required this.name,
    this.quantity = '',
    this.unit = '',
    this.checked = false,
  });

  /// Creates an [ExtractionIngredient] from JSON data.
  factory ExtractionIngredient.fromJson(Map<String, dynamic> json) =>
      _$ExtractionIngredientFromJson(json);

  /// Converts this [ExtractionIngredient] to JSON.
  Map<String, dynamic> toJson() => _$ExtractionIngredientToJson(this);

  /// Creates a copy of this [ExtractionIngredient] with the given fields replaced.
  ExtractionIngredient copyWith({
    String? name,
    String? quantity,
    String? unit,
    bool? checked,
  }) {
    return ExtractionIngredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      checked: checked ?? this.checked,
    );
  }

  @override
  List<Object?> get props => [name, quantity, unit, checked];
}
