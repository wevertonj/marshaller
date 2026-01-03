import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:marshaller/domain/enums/app_locale.dart';
import 'package:marshaller/domain/enums/theme_options.dart';

class AppSettings extends Equatable {
  final ThemeOptions theme;
  final ThemeMode darkMode;
  final bool showAlertPage;
  final AppLocale locale;
  const AppSettings({
    required this.theme,
    required this.darkMode,
    required this.showAlertPage,
    this.locale = AppLocale.system,
  });
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      theme: ThemeOptions.values.firstWhere(
        (e) => e.colorName == json['theme'],
        orElse: () => ThemeOptions.green,
      ),
      darkMode: ThemeMode.values.firstWhere(
        (e) => e.toString() == json['darkMode'],
        orElse: () => ThemeMode.system,
      ),
      showAlertPage: json['showAlertPage'] as bool? ?? false,
      locale: AppLocale.fromString(json['locale'] as String?),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'theme': theme.colorName,
      'darkMode': darkMode.toString(),
      'showAlertPage': showAlertPage,
      'locale': locale.name,
    };
  }

  AppSettings copyWith({
    ThemeOptions? theme,
    ThemeMode? darkMode,
    bool? showAlertPage,
    AppLocale? locale,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      darkMode: darkMode ?? this.darkMode,
      showAlertPage: showAlertPage ?? this.showAlertPage,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [theme, darkMode, showAlertPage, locale];
}
