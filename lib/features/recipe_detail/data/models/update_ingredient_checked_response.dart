import 'package:equatable/equatable.dart';

/// Response schema for updating ingredient checked status.
///
/// Based on the UpdateIngredientCheckedResponse schema from the OpenAPI specification.
class UpdateIngredientCheckedResponse extends Equatable {
  /// Whether the update was successful
  final bool success;

  /// Success or error message
  final String message;

  /// Name of the updated ingredient
  final String ingredientName;

  /// New checked status
  final bool checked;

  /// Creates an [UpdateIngredientCheckedResponse].
  const UpdateIngredientCheckedResponse({
    required this.success,
    required this.message,
    required this.ingredientName,
    required this.checked,
  });

  /// Creates an [UpdateIngredientCheckedResponse] from JSON.
  factory UpdateIngredientCheckedResponse.fromJson(Map<String, dynamic> json) {
    return UpdateIngredientCheckedResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      ingredientName: json['ingredient_name'] as String,
      checked: json['checked'] as bool,
    );
  }

  /// Converts this [UpdateIngredientCheckedResponse] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'ingredient_name': ingredientName,
      'checked': checked,
    };
  }

  @override
  List<Object?> get props => [success, message, ingredientName, checked];
}
