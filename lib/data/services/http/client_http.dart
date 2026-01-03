import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/config/app_config.dart';
import 'package:marshaller/data/services/http/http_error_handler.dart';

class ClientHttp {
  final Dio _dio = Dio();
  final HttpErrorHandler _errorHandler;
  ClientHttp({required HttpErrorHandler errorHandler})
    : _errorHandler = errorHandler {
    _dio.options.baseUrl = AppConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
  AsyncResult<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _makeRequest(() => _dio.get(path, queryParameters: queryParameters));
  }

  AsyncResult<Response> post(String path, {Map<String, dynamic>? data}) async {
    return _makeRequest(() => _dio.post(path, data: data));
  }

  AsyncResult<Response> put(String path, {Map<String, dynamic>? data}) async {
    return _makeRequest(() => _dio.put(path, data: data));
  }

  AsyncResult<Response> patch(String path, {Map<String, dynamic>? data}) async {
    return _makeRequest(() => _dio.patch(path, data: data));
  }

  AsyncResult<Response> delete(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return _makeRequest(() => _dio.delete(path, data: data));
  }

  AsyncResult<Response> _makeRequest(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return Success(response);
    } on DioException catch (e) {
      return Failure(_errorHandler.handleError(e));
    }
  }
}
