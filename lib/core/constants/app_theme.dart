import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Application theme configuration.
///
/// This class provides theme data that integrates Material 3 with custom
/// design constants. The ColorScheme references DesignConstants to ensure
/// consistency across the application.
class AppTheme {
  /// Dark theme configuration (default theme)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: DesignConstants.fontFamily,

      // ColorScheme references DesignConstants for consistency
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: DesignConstants.primary,
        onPrimary: DesignConstants.text,
        primaryContainer: DesignConstants.primarySubtle,
        onPrimaryContainer: DesignConstants.text,
        secondary: DesignConstants.secondary,
        onSecondary: DesignConstants.background,
        secondaryContainer: DesignConstants.secondary,
        onSecondaryContainer: DesignConstants.background,
        tertiary: DesignConstants.primary,
        onTertiary: DesignConstants.text,
        error: const Color(0xFFCF6679),
        onError: DesignConstants.text,
        surface: DesignConstants.background,
        onSurface: DesignConstants.text,
      ),

      // Scaffold background
      scaffoldBackgroundColor: DesignConstants.background,

      // Card theme
      cardTheme: CardThemeData(
        color: DesignConstants.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignConstants.cardRadius),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignConstants.primary,
          foregroundColor: DesignConstants.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
            side: BorderSide(
              color: DesignConstants.buttonStroke,
              width: DesignConstants.buttonBorderSize,
            ),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DesignConstants.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DesignConstants.text,
          side: BorderSide(
            color: DesignConstants.buttonStroke,
            width: DesignConstants.buttonBorderSize,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignConstants.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
          borderSide: BorderSide(
            color: DesignConstants.buttonStroke,
            width: DesignConstants.buttonBorderSize,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
          borderSide: BorderSide(
            color: DesignConstants.buttonStroke,
            width: DesignConstants.buttonBorderSize,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
          borderSide: BorderSide(
            color: DesignConstants.primary,
            width: DesignConstants.buttonBorderSize,
          ),
        ),
      ),

      // Text theme with Nunito font
      textTheme: const TextTheme(
        displayLarge: DesignConstants.h1,
        displayMedium: DesignConstants.h1,
        displaySmall: DesignConstants.h1,
        headlineLarge: DesignConstants.h1,
        headlineMedium: DesignConstants.h2,
        headlineSmall: DesignConstants.h3,
        titleLarge: DesignConstants.title,
        titleMedium: DesignConstants.h2,
        titleSmall: DesignConstants.h3,
        bodyLarge: DesignConstants.h3,
        bodyMedium: DesignConstants.p,
        bodySmall: DesignConstants.p,
        labelLarge: DesignConstants.h3,
        labelMedium: DesignConstants.p,
        labelSmall: DesignConstants.p,
      ),
    );
  }

  // Private constructor to prevent instantiation
  AppTheme._();
}
