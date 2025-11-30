import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'import_request.g.dart';

/// Request model for recipe import (used by all platforms).
///
/// This model matches the OpenAPI ImportRequest schema.
@JsonSerializable()
class ImportRequest extends Equatable {
  /// URL from any supported platform (TikTok, YouTube, Instagram, or recipe website)
  final String url;

  /// User ID for saving the recipe (if provided, recipe will be saved)
  @JsonKey(name: 'user_id')
  final String? userId;

  /// If True, uses mock data instead of real API calls
  final bool mock;

  /// If True, return recipe_id immediately for polling instead of waiting for completion
  final bool polling;

  /// Creates an [ImportRequest] instance.
  const ImportRequest({
    required this.url,
    this.userId,
    this.mock = false,
    this.polling = true, // Default to true for async import
  });

  /// Creates an [ImportRequest] from JSON data.
  factory ImportRequest.fromJson(Map<String, dynamic> json) =>
      _$ImportRequestFromJson(json);

  /// Converts this [ImportRequest] to JSON.
  Map<String, dynamic> toJson() => _$ImportRequestToJson(this);

  /// Creates a copy of this [ImportRequest] with the given fields replaced.
  ImportRequest copyWith({
    String? url,
    String? userId,
    bool? mock,
    bool? polling,
  }) {
    return ImportRequest(
      url: url ?? this.url,
      userId: userId ?? this.userId,
      mock: mock ?? this.mock,
      polling: polling ?? this.polling,
    );
  }

  @override
  List<Object?> get props => [url, userId, mock, polling];
}
