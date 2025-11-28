import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Recipe difficulty levels.
enum Difficulty {
  /// Easy difficulty (1)
  easy(1, 'simple', DesignConstants.easyDifficulty),

  /// Medium difficulty (2)
  medium(2, 'medium', DesignConstants.mediumDifficulty),

  /// Complex difficulty (3)
  complex(3, 'complex', DesignConstants.hardDifficulty);

  /// Numeric value of the difficulty
  final int value;

  /// Display name for the difficulty
  final String displayName;

  /// Color associated with this difficulty level
  final Color color;

  const Difficulty(this.value, this.displayName, this.color);

  /// Creates a Difficulty from an integer value.
  static Difficulty fromValue(int value) {
    switch (value) {
      case 1:
        return Difficulty.easy;
      case 2:
        return Difficulty.medium;
      case 3:
        return Difficulty.complex;
      default:
        return Difficulty.medium;
    }
  }
}
