import 'dart:async';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/settings/app_settings_repository.dart';
import 'package:marshaller/domain/entities/app_settings.dart';
import 'package:marshaller/domain/enums/app_locale.dart';
import 'package:marshaller/domain/enums/theme_options.dart';
import 'package:marshaller/ui/core/theme/default_settings_values.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppSettingsRepository _settingsRepository;
  late final saveThemeCommand = Command1(_saveTheme);
  late final saveDarkModeCommand = Command1(_saveDarkMode);
  late final saveLocaleCommand = Command1(_saveLocale);
  late final showAlertPageCommand = Command1(_setShowAlertPage);
  AppSettings _settings = const DefaultSettingsValues().toAppSettings();
  AppSettings get settings => _settings;
  StreamSubscription<AppSettings>? _settingsSubscription;
  SettingsViewModel({required AppSettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository {
    _init();
  }
  void _init() {
    saveThemeCommand.addListener(notifyListeners);
    saveDarkModeCommand.addListener(notifyListeners);
    saveLocaleCommand.addListener(notifyListeners);
    _settingsRepository.getSettings().onSuccess((s) {
      _settings = s;
      notifyListeners();
    });
    _settingsSubscription = _settingsRepository.settingsObserver().listen((
      newSettings,
    ) {
      _settings = newSettings;
      notifyListeners();
    });
  }

  AsyncResult<AppSettings> _saveTheme(ThemeOptions theme) {
    return _settingsRepository.saveTheme(theme);
  }

  AsyncResult<AppSettings> _saveDarkMode(ThemeMode darkMode) {
    return _settingsRepository.saveDarkMode(darkMode);
  }

  AsyncResult<AppSettings> _saveLocale(AppLocale locale) {
    return _settingsRepository.saveLocale(locale);
  }

  AsyncResult<AppSettings> _setShowAlertPage(bool show) {
    return _settingsRepository.saveShowAlertPage(show);
  }

  @override
  void dispose() {
    _settingsSubscription?.cancel();
    saveThemeCommand.removeListener(notifyListeners);
    saveDarkModeCommand.removeListener(notifyListeners);
    saveLocaleCommand.removeListener(notifyListeners);
    super.dispose();
  }
}
