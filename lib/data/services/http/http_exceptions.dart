sealed class HttpException implements Exception {
  final String message;
  final int? statusCode;
  const HttpException(this.message, this.statusCode);
  @override
  String toString() => message;
}

final class BadRequestException extends HttpException {
  const BadRequestException(String message) : super(message, 400);
}

final class UnauthorizedException extends HttpException {
  const UnauthorizedException(String message) : super(message, 401);
}

final class ForbiddenException extends HttpException {
  const ForbiddenException(String message) : super(message, 403);
}

final class NotFoundException extends HttpException {
  const NotFoundException(String message) : super(message, 404);
}

final class ConflictException extends HttpException {
  const ConflictException(String message) : super(message, 409);
}

final class ValidationException extends HttpException {
  const ValidationException(String message) : super(message, 422);
}

final class TooManyRequestsException extends HttpException {
  const TooManyRequestsException(String message) : super(message, 429);
}

final class ServerException extends HttpException {
  const ServerException(String message) : super(message, 500);
}

final class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException(String message) : super(message, 503);
}

final class TimeoutException extends HttpException {
  const TimeoutException(String message) : super(message, null);
}

final class NetworkException extends HttpException {
  const NetworkException(String message) : super(message, null);
}

final class UnknownHttpException extends HttpException {
  const UnknownHttpException(String message) : super(message, null);
}
