/// API-related constants.
///
/// This class contains constants for API endpoints, base URLs, and other
/// API-related configuration values.
class ApiConstants {
  /// Base URL for the API (development)
  static const String baseUrl = 'http://192.168.1.12:8000';

  /// Endpoint for fetching user recipes
  /// Use with path parameter: /v1/database/users/{user_id}/recipes
  static const String recipesEndpoint = '/v1/database/users';

  // Private constructor to prevent instantiation
  ApiConstants._();
}
