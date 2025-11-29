import 'package:flutter/material.dart';

/// Design constants for the Flutter-Squillo application.
///
/// This class serves as the single source of truth for all design values
/// including colors, radiuses, borders, and spacing. It can be inherited
/// to create theme variations (e.g., light theme, brand variations).
///
/// Usage:
/// ```dart
/// Container(
///   color: DesignConstants.primary,
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(DesignConstants.defaultRadius),
///   ),
/// )
/// ```
class DesignConstants {
  // Colors

  /// Primary brand color - Orange
  static const Color primary = Color(0xFFE66E36);

  /// Primary color at 50% opacity
  static final Color primaryHalf = primary.withValues(alpha: 0.5);

  /// Primary color at 20% opacity for subtle backgrounds / cards
  static final Color primarySubtle = primary.withValues(alpha: 0.2);

  /// Secondary brand color - Green
  static const Color secondary = Color(0xFFB5F54B);

  /// Main background color - Dark gray
  static const Color background = Color(0xFF121619);

  /// Primary text color - Light pink/white
  static const Color text = Color(0xFFF3E8EE);

  /// Text color at 50% opacity for secondary text
  static final Color textHalf = text.withValues(alpha: 0.5);

  /// Button stroke/border color - Dark gray
  static const Color buttonStroke = Color(0xFF2E2E2E);

  // Easy difficulty color
  static const Color easyDifficulty = Color(0xFF119E1D);

  // Medium difficulty color
  static const Color mediumDifficulty = Color(0xFF36C3E6);

  // Hard difficulty color
  static const Color hardDifficulty = Color(0xFF920BCB);

  // Design Values

  /// Border radius for buttons
  static const double buttonRadius = 16.0;

  /// Border radius for cards
  static const double cardRadius = 30.0;

  /// Border width for buttons
  static const double buttonBorderSize = 3.0;

  /// Border width for card
  static const double cardBorderSize = 4.0;

  /// Screen horizontal padding for consistency across screens
  static const double screenHorizontalPadding = 24.0;

  // Typography

  /// Font family
  static const String fontFamily = 'Nunito';

  /// Title text style (regular, 30) - not used in mockup
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 30,
    color: text,
  );

  /// H1 text style (light, 30)
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 30,
    color: text,
  );

  /// H2 text style (light, 18)
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 18,
    color: text,
  );

  /// H3 text style (regular, 15)
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: text,
  );

  /// Paragraph text style (regular, 12)
  static const TextStyle p = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: text,
  );

  // Private constructor to prevent instantiation
  DesignConstants._();
}
