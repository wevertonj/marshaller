import 'package:flutter/material.dart';
import 'package:marshaller/domain/entities/app_settings.dart';
import 'package:marshaller/domain/enums/theme_options.dart';

class DefaultSettingsValues {
  final ThemeMode darkMode;
  final ThemeOptions theme;
  final bool showAlertPage;
  const DefaultSettingsValues({
    this.darkMode = ThemeMode.light,
    this.theme = ThemeOptions.green,
    this.showAlertPage = true,
  });
  DefaultSettingsValues copyWith({
    ThemeMode? darkMode,
    ThemeOptions? theme,
    bool? showAlertPage,
  }) {
    return DefaultSettingsValues(
      darkMode: darkMode ?? this.darkMode,
      theme: theme ?? this.theme,
      showAlertPage: showAlertPage ?? this.showAlertPage,
    );
  }

  static DefaultSettingsValues lerp(
    DefaultSettingsValues a,
    DefaultSettingsValues b,
    double t,
  ) {
    return DefaultSettingsValues(
      darkMode: t < 0.5 ? a.darkMode : b.darkMode,
      theme: t < 0.5 ? a.theme : b.theme,
      showAlertPage: t < 0.5 ? a.showAlertPage : b.showAlertPage,
    );
  }
}

extension DefaultSettingsValuesX on DefaultSettingsValues {
  AppSettings toAppSettings() {
    return AppSettings(
      theme: theme,
      darkMode: darkMode,
      showAlertPage: showAlertPage,
    );
  }
}
