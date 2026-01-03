import 'package:marshaller/utils/exceptions/exception_level.dart';
import 'package:marshaller/utils/exceptions/exceptions.dart';

class LocalStorageException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.info;
  LocalStorageException(super.message, [super.stackTrace]);
}

class LocalStorageNotFoundException extends LocalStorageException {
  LocalStorageNotFoundException(super.message, [super.stackTrace]);
}

class AuthException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.warning;
  AuthException(super.message, [super.stackTrace]);
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(super.message, [super.stackTrace]);
}

class BiometricException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.info;
  BiometricException(super.message, [super.stackTrace]);
}

class BiometricCancelledException extends BiometricException {
  BiometricCancelledException(super.message, [super.stackTrace]);
}

class BiometricKeyGenerationException extends BiometricException {
  @override
  ExceptionLevel get level => ExceptionLevel.error;
  BiometricKeyGenerationException(super.message, [super.stackTrace]);
}

class BiometricKeyNotFoundException extends BiometricException {
  BiometricKeyNotFoundException(super.message, [super.stackTrace]);
}

class BiometricSigningException extends BiometricException {
  @override
  ExceptionLevel get level => ExceptionLevel.error;
  BiometricSigningException(super.message, [super.stackTrace]);
}

class BiometricAuthenticationException extends BiometricException {
  BiometricAuthenticationException(super.message, [super.stackTrace]);
}

class DeviceFingerprintException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.error;
  DeviceFingerprintException(super.message, [super.stackTrace]);
}

class UnsupportedPlatformException extends DeviceFingerprintException {
  UnsupportedPlatformException(super.message, [super.stackTrace]);
}

class DeviceInfoException extends DeviceFingerprintException {
  DeviceInfoException(super.message, [super.stackTrace]);
}

class DeviceNameException extends DeviceFingerprintException {
  DeviceNameException(super.message, [super.stackTrace]);
}

abstract class ClientHttpException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.critical;
  ClientHttpException(super.message, [super.stackTrace]);
}

class HttpNotFoundException extends ClientHttpException {
  @override
  ExceptionLevel get level => ExceptionLevel.info;
  HttpNotFoundException(super.message, [super.stackTrace]);
}

class HttpConflictException extends ClientHttpException {
  @override
  ExceptionLevel get level => ExceptionLevel.warning;
  HttpConflictException(super.message, [super.stackTrace]);
}

class HttpBadRequestException extends ClientHttpException {
  @override
  ExceptionLevel get level => ExceptionLevel.warning;
  HttpBadRequestException(super.message, [super.stackTrace]);
}

class HttpUnauthorizedException extends ClientHttpException {
  @override
  ExceptionLevel get level => ExceptionLevel.info;
  HttpUnauthorizedException(super.message, [super.stackTrace]);
}

class HttpTooManyRequestsException extends ClientHttpException {
  @override
  ExceptionLevel get level => ExceptionLevel.info;
  HttpTooManyRequestsException(super.message, [super.stackTrace]);
}

class HttpForbiddenException extends ClientHttpException {
  @override
  ExceptionLevel get level => ExceptionLevel.warning;
  HttpForbiddenException(super.message, [super.stackTrace]);
}

class HttpInternalServerErrorException extends ClientHttpException {
  HttpInternalServerErrorException(super.message, [super.stackTrace]);
}

class HttpServiceUnavailableException extends ClientHttpException {
  HttpServiceUnavailableException(super.message, [super.stackTrace]);
}

class HttpUnknownException extends ClientHttpException {
  HttpUnknownException(super.message, [super.stackTrace]);
}

class DeepLinkException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.info;
  DeepLinkException(super.message, [super.stackTrace]);
}

class DeepLinkNotFoundException extends DeepLinkException {
  DeepLinkNotFoundException(super.message, [super.stackTrace]);
}

class DeepLinkStorageException extends DeepLinkException {
  @override
  ExceptionLevel get level => ExceptionLevel.error;
  DeepLinkStorageException(super.message, [super.stackTrace]);
}

class NotificationException extends AppException {
  @override
  final ExceptionLevel level = ExceptionLevel.error;
  NotificationException(super.message, [super.stackTrace]);
}

class NotificationTokenException extends NotificationException {
  NotificationTokenException(super.message, [super.stackTrace]);
}
