import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/techniques/data/models/simplified_technique.dart';

/// A card displaying a cooking technique.
///
/// Shows the technique image and name with a custom background color.
class TechniqueCard extends StatelessWidget {
  /// The technique to display
  final SimplifiedTechnique technique;

  /// Creates a [TechniqueCard].
  const TechniqueCard({super.key, required this.technique});

  /// Converts hex color string to Color object.
  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _hexToColor(technique.backgroundColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(DesignConstants.cardRadius),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Image.network(
              technique.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to icon if image fails to load
                return const Icon(
                  Icons.restaurant_menu,
                  color: DesignConstants.text,
                  size: 48,
                );
              },
            ),
          ),
        ),
        Text(
          technique.name,
          style: DesignConstants.h3.copyWith(color: DesignConstants.text),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
