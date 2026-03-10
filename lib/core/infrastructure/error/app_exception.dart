// Custom exception types for consistent error handling across all repos.

enum ServerExceptionType {
  notFound,
  unauthorized,
  general,
}

class ServerException implements Exception {
  const ServerException({
    required this.type,
    required this.message,
  });

  final ServerExceptionType type;
  final String message;

  @override
  String toString() => 'ServerException($type): $message';
}

class CacheException implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  String toString() => 'CacheException: $message';
}
