import 'package:marshaller/utils/exceptions/crashlytics_reporter.dart';
import 'package:marshaller/utils/exceptions/exception_level.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  ExceptionLevel get level;
  AppException(this.message, [this.stackTrace]);
  @override
  String toString() {
    report();
    return message;
  }

  void report() {
    CrashlyticsReporter.report(message, stackTrace: stackTrace, level: level);
  }
}

class InvalidException extends AppException {
  final String key;
  @override
  final ExceptionLevel level = ExceptionLevel.info;
  InvalidException(super.message, this.key, [super.stackTrace]);
}
