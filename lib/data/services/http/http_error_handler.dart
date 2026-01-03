import 'package:dio/dio.dart';
import 'package:marshaller/data/services/http/http_exceptions.dart';

class HttpErrorHandler {
  HttpException handleError(DioException error) {
    final int? statusCode = error.response?.statusCode;
    final Map<String, dynamic>? data = error.response?.data;
    final String? message = data?['message'];
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeoutException(message ?? 'Connection timeout');
    }
    if (error.type == DioExceptionType.connectionError) {
      return NetworkException(message ?? 'No internet connection');
    }
    if (statusCode == null) {
      return UnknownHttpException(error.message ?? 'Unknown error');
    }
    return _mapStatusCodeToException(statusCode, message);
  }

  HttpException _mapStatusCodeToException(int statusCode, String? message) {
    return switch (statusCode) {
      400 => BadRequestException(message ?? 'Bad request'),
      401 => UnauthorizedException(message ?? 'Unauthorized'),
      403 => ForbiddenException(message ?? 'Forbidden'),
      404 => NotFoundException(message ?? 'Not found'),
      409 => ConflictException(message ?? 'Conflict'),
      422 => ValidationException(message ?? 'Validation error'),
      429 => TooManyRequestsException(message ?? 'Too many requests'),
      500 => ServerException(message ?? 'Internal server error'),
      503 => ServiceUnavailableException(message ?? 'Service unavailable'),
      _ => UnknownHttpException(message ?? 'Unknown error'),
    };
  }
}
