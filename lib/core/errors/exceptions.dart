/// Custom exception for network-related errors.
///
/// Thrown when there are connectivity issues or network failures.
class NetworkException implements Exception {
  /// Error message describing the network issue
  final String message;

  /// Creates a [NetworkException] with the given [message].
  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

/// Custom exception for server-related errors.
///
/// Thrown when the server returns an error response (4xx, 5xx status codes).
class ServerException implements Exception {
  /// Error message from the server
  final String message;

  /// HTTP status code
  final int? statusCode;

  /// Creates a [ServerException] with the given [message] and optional [statusCode].
  const ServerException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
