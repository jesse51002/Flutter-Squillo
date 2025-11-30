/// Application-wide constants.
///
/// This class contains constants that are used throughout the application
/// including user IDs, timeouts, and other configuration values.
class AppConstants {
  /// Default user ID for the application
  static const String kDefaultUserId =
      'user_20250116_11111111-1111-1111-1111-111111111111';

  /// Default timeout for HTTP requests
  static const Duration kDefaultTimeout = Duration(seconds: 30);

  static const String kDefaultImageUrl =
      "https://static.vecteezy.com/system/resources/previews/028/299/128/non_2x/a-well-organized-kitchen-counter-filled-with-fresh-ingredients-and-cooking-utensils-background-with-empty-space-for-text-photo.jpg";

  // Private constructor to prevent instantiation
  AppConstants._();
}
