import 'dart:ui';

enum AppLocale {
  system,
  en,
  es,
  pt;

  Locale? toLocale() {
    switch (this) {
      case AppLocale.system:
        return null;
      case AppLocale.en:
        return const Locale('en', 'US');
      case AppLocale.es:
        return const Locale('es', 'ES');
      case AppLocale.pt:
        return const Locale('pt', 'BR');
    }
  }

  String get displayName {
    switch (this) {
      case AppLocale.system:
        return 'System';
      case AppLocale.en:
        return 'English';
      case AppLocale.es:
        return 'Español';
      case AppLocale.pt:
        return 'Português';
    }
  }

  static AppLocale fromString(String? value) {
    if (value == null) return AppLocale.system;
    return AppLocale.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppLocale.system,
    );
  }
}
