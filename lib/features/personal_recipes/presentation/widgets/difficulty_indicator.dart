import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/core/constants/difficulty.dart';

/// An indicator displaying recipe difficulty level.
///
/// Shows a colored circle with the difficulty name.
class DifficultyIndicator extends StatelessWidget {
  /// The difficulty level
  final Difficulty difficulty;

  /// Optional size for the circle (default: 20)
  final double size;

  const DifficultyIndicator({
    super.key,
    required this.difficulty,
    this.size = 20,
  });

  /// Builds the complete difficulty legend section with header.
  ///
  /// Displays "new techniques" header with chef hat icon,
  /// followed by all difficulty indicators in a row.
  static Widget buildLegendSection() {
    return Column(
      children: [
        // New techniques section header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/chef_hat.png', width: 16, height: 16),
            const SizedBox(width: 8),
            Text('new techniques ', style: DesignConstants.h3),
          ],
        ),
        const SizedBox(height: 4),
        // Difficulty legend - centered horizontally
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DifficultyIndicator(difficulty: Difficulty.easy),
            const SizedBox(width: 16),
            DifficultyIndicator(difficulty: Difficulty.medium),
            const SizedBox(width: 16),
            DifficultyIndicator(difficulty: Difficulty.complex),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: (DesignConstants.h3.fontSize as double) * 0.7,
          height: (DesignConstants.h3.fontSize as double) * 0.7,
          decoration: BoxDecoration(
            color: difficulty.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(difficulty.displayName, style: DesignConstants.h3),
      ],
    );
  }
}
