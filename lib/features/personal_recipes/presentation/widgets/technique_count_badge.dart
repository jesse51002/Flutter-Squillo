import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// A badge displaying the count of techniques in a recipe.
///
/// Shows a small circular badge with technique count and chef hat icon.
class TechniqueCountBadge extends StatelessWidget {
  /// The number of techniques
  final int count;

  /// Optional size for the badge (default: 32)
  final double size;

  const TechniqueCountBadge({
    super.key,
    required this.count,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.25,
        vertical: size * 0.15,
      ),
      decoration: BoxDecoration(
        color: DesignConstants.background.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: DesignConstants.primary,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/chef_hat.png',
            width: size * 0.5,
            height: size * 0.5,
            fit: BoxFit.contain,
          ),
          SizedBox(width: size * 0.15),
          Text(
            count.toString(),
            style: TextStyle(
              color: DesignConstants.text,
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
