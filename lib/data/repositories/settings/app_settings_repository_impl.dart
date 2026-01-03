import 'dart:async';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/settings/app_settings_repository.dart';
import 'package:marshaller/data/services/app_settings/app_settings_local_storage.dart';
import 'package:marshaller/domain/entities/app_settings.dart';
import 'package:marshaller/domain/enums/app_locale.dart';
import 'package:marshaller/domain/enums/theme_options.dart';
import 'package:marshaller/ui/core/theme/default_settings_values.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  final AppSettingsLocalStorage _localStorage;
  final _streamController = StreamController<AppSettings>.broadcast();
  AppSettingsRepositoryImpl(this._localStorage);
  @override
  AsyncResult<AppSettings> getSettings() {
    return _localStorage.getSettings().onSuccess(_streamController.add);
  }

  @override
  AsyncResult<AppSettings> saveSettings(AppSettings settings) {
    return _localStorage
        .saveSettings(settings)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<AppSettings> saveTheme(ThemeOptions theme) async {
    final DefaultSettingsValues defaultSettings = DefaultSettingsValues();
    final AppSettings settings = await getSettings().getOrDefault(
      defaultSettings.toAppSettings(),
    );
    final newSettings = settings.copyWith(theme: theme);
    return saveSettings(newSettings).onSuccess(_streamController.add);
  }

  @override
  AsyncResult<AppSettings> saveDarkMode(ThemeMode darkMode) async {
    final DefaultSettingsValues defaultSettings = DefaultSettingsValues();
    final AppSettings settings = await getSettings().getOrDefault(
      defaultSettings.toAppSettings(),
    );
    final newSettings = settings.copyWith(darkMode: darkMode);
    return saveSettings(newSettings).onSuccess(_streamController.add);
  }

  @override
  AsyncResult<AppSettings> saveShowAlertPage(bool showAlertPage) async {
    final DefaultSettingsValues defaultSettings = DefaultSettingsValues();
    final AppSettings settings = await getSettings().getOrDefault(
      defaultSettings.toAppSettings(),
    );
    final newSettings = settings.copyWith(showAlertPage: showAlertPage);
    return saveSettings(newSettings).onSuccess(_streamController.add);
  }

  @override
  AsyncResult<AppSettings> saveLocale(AppLocale locale) async {
    final DefaultSettingsValues defaultSettings = DefaultSettingsValues();
    final AppSettings settings = await getSettings().getOrDefault(
      defaultSettings.toAppSettings(),
    );
    final newSettings = settings.copyWith(locale: locale);
    return saveSettings(newSettings).onSuccess(_streamController.add);
  }

  @override
  Stream<AppSettings> settingsObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
