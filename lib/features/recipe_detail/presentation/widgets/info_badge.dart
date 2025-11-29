import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// A badge displaying an icon, value, and label for recipe information.
///
/// Used in the info badges grid to show difficulty, time, and technique count.
class InfoBadge extends StatelessWidget {
  /// The icon to display
  final String imgPth;

  /// The main label text (e.g., "difficulty", "active time")
  final String label;

  /// The value to display (e.g., "beginner", "15 min")
  final String value;

  /// Creates an [InfoBadge].
  const InfoBadge({
    super.key,
    required this.imgPth,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 32,
      decoration: BoxDecoration(
        color: DesignConstants.background,
        borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
        border: Border.all(
          color: DesignConstants.buttonStroke,
          width: DesignConstants.buttonBorderSize,
        ),
      ),
      child: Row(
        children: [
          // Icon on the left
          Image.asset(imgPth, width: 28, height: 28),
          const SizedBox(width: 12),
          // Text stack on the right
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: DesignConstants.h3.copyWith(
                    color: DesignConstants.text,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: DesignConstants.p.copyWith(
                    color: DesignConstants.textHalf,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
