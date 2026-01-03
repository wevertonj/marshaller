import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:marshaller/utils/exceptions/exception_level.dart';
import 'package:marshaller/utils/helpers/app_logger.dart';

class CrashlyticsReporter {
  static bool _warnedAboutFirebase = false;
  static void report(
    String message, {
    required ExceptionLevel level,
    StackTrace? stackTrace,
  }) {
    if (level.index < ExceptionLevel.warning.index) return;
    if (kDebugMode) {
      _logWithAppLogger(message, level: level, stackTrace: stackTrace);
    } else {
      _reportToCrashlytics(message, level: level, stackTrace: stackTrace);
    }
  }

  static void _reportToCrashlytics(
    String message, {
    required ExceptionLevel level,
    StackTrace? stackTrace,
  }) {
    if (Firebase.apps.isEmpty) {
      if (!_warnedAboutFirebase) {
        _warnedAboutFirebase = true;
        AppLogger.warning(
          'Firebase não inicializado. Crashlytics desabilitado.',
        );
      }
      _logWithAppLogger(message, level: level, stackTrace: stackTrace);
      return;
    }
    try {
      final crashlytics = FirebaseCrashlytics.instance;
      crashlytics.recordError(
        message,
        stackTrace,
        fatal: level == ExceptionLevel.critical,
      );
      crashlytics.setCustomKey('severity', level.name);
    } catch (e) {
      _logWithAppLogger(message, level: level, stackTrace: stackTrace);
    }
  }

  static void _logWithAppLogger(
    String message, {
    required ExceptionLevel level,
    StackTrace? stackTrace,
  }) {
    switch (level) {
      case ExceptionLevel.warning:
        AppLogger.warning(message);
        break;
      case ExceptionLevel.error:
        AppLogger.error(message, error: stackTrace);
        break;
      case ExceptionLevel.critical:
        AppLogger.error('CRITICAL: $message', error: stackTrace);
        break;
      case ExceptionLevel.info:
        AppLogger.info(message);
        break;
    }
  }
}
