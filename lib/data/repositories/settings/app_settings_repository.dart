import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/domain/entities/app_settings.dart';
import 'package:marshaller/domain/enums/app_locale.dart';
import 'package:marshaller/domain/enums/theme_options.dart';

abstract interface class AppSettingsRepository {
  AsyncResult<AppSettings> getSettings();
  AsyncResult<AppSettings> saveSettings(AppSettings settings);
  AsyncResult<AppSettings> saveTheme(ThemeOptions theme);
  AsyncResult<AppSettings> saveDarkMode(ThemeMode darkMode);
  AsyncResult<AppSettings> saveShowAlertPage(bool showAlertPage);
  AsyncResult<AppSettings> saveLocale(AppLocale locale);
  Stream<AppSettings> settingsObserver();
  void dispose();
}
