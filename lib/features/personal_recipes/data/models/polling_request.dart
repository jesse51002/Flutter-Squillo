import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'polling_request.g.dart';

/// Request model for polling recipe import status.
@JsonSerializable()
class PollingRequest extends Equatable {
  /// List of recipe IDs to check status for
  @JsonKey(name: 'recipe_ids')
  final List<String> recipeIds;

  /// User ID who owns the recipes
  @JsonKey(name: 'user_id')
  final String userId;

  const PollingRequest({
    required this.recipeIds,
    required this.userId,
  });

  factory PollingRequest.fromJson(Map<String, dynamic> json) =>
      _$PollingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PollingRequestToJson(this);

  @override
  List<Object?> get props => [recipeIds, userId];
}
