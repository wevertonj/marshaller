import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();
  static void info(String message, {dynamic error, StackTrace? stackTrace}) {
    _log('INFO', message, error, stackTrace);
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _log('ERROR', message, error, stackTrace);
  }

  static void warning(String message, {dynamic error, StackTrace? stackTrace}) {
    _log('WARNING', message, error, stackTrace);
  }

  static void debug(String message, {dynamic error, StackTrace? stackTrace}) {
    _log('DEBUG', message, error, stackTrace);
  }

  static void auth(String message) {
    _log('AUTH', message, null, null, emoji: '🔐');
  }

  static void navigation(String message) {
    _log('NAVIGATION', message, null, null, emoji: '🔀');
  }

  static void deepLink(String message) {
    _log('DEEP_LINK', message, null, null, emoji: '🔗');
  }

  static void firstAccess(String message) {
    _log('FIRST_ACCESS', message, null, null, emoji: '🔄');
  }

  static void notification(String message) {
    _log('NOTIFICATION', message, null, null, emoji: '📱');
  }

  static void _log(
    String tag,
    String message,
    dynamic error,
    StackTrace? stackTrace, {
    String? emoji,
  }) {
    if (kDebugMode) {
      final prefix = emoji != null ? '$emoji ' : '';
      final errorInfo = error != null ? ' | Error: $error' : '';
      final stackInfo = stackTrace != null ? '\nStack: $stackTrace' : '';
      developer.log(
        '$prefix$message$errorInfo$stackInfo',
        name: tag,
        time: DateTime.now(),
      );
    }
  }
}
