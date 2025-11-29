import 'package:equatable/equatable.dart';

/// Simplified technique information for recommendations and display.
///
/// Based on the SimplifiedTechnique schema from the OpenAPI specification.
class SimplifiedTechnique extends Equatable {
  /// Technique ID
  final String id;

  /// Technique name
  final String name;

  /// Technique description
  final String description;

  /// Technique video URL
  final String videoUrl;

  /// Base technique image URL
  final String image;

  /// Technique badge image URL (nullable)
  final String? badgeImage;

  /// Hex color of background for technique (defaults to #000000)
  final String backgroundColor;

  /// Creates a [SimplifiedTechnique].
  const SimplifiedTechnique({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.image,
    this.badgeImage,
    this.backgroundColor = '#000000',
  });

  /// Creates a [SimplifiedTechnique] from JSON.
  factory SimplifiedTechnique.fromJson(Map<String, dynamic> json) {
    return SimplifiedTechnique(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      videoUrl: json['video_url'] as String,
      image: json['image'] as String,
      badgeImage: json['badge_image'] as String?,
      backgroundColor: json['background_color'] as String? ?? '#000000',
    );
  }

  /// Converts this [SimplifiedTechnique] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'video_url': videoUrl,
      'image': image,
      'badge_image': badgeImage,
      'background_color': backgroundColor,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    videoUrl,
    image,
    badgeImage,
    backgroundColor,
  ];
}
