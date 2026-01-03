class AppConfig {
  static const int inactivityTimeout = 5;
  static const int apiVersion = 1;
  static final String baseUrl = const String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
  static bool get isProduction =>
      !baseUrl.contains('localhost') && !baseUrl.contains('10.0.2.2');
  static bool get enableBasicLogs => !isProduction;
  static bool get enableAdvancedLogs => false;
}
