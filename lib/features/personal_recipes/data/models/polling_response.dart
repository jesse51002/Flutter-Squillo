import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_status.dart';

part 'polling_response.g.dart';

/// Response model for polling recipe import status.
@JsonSerializable()
class PollingResponse extends Equatable {
  /// Dictionary mapping recipe_id to its status
  final Map<String, RecipeStatus> statuses;

  const PollingResponse({
    required this.statuses,
  });

  factory PollingResponse.fromJson(Map<String, dynamic> json) =>
      _$PollingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PollingResponseToJson(this);

  @override
  List<Object?> get props => [statuses];
}
