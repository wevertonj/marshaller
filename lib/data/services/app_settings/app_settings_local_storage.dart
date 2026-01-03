import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/services/storage/local_storage.dart';
import 'package:marshaller/domain/entities/app_settings.dart';
import 'package:marshaller/ui/core/theme/default_settings_values.dart';
import 'package:marshaller/utils/exceptions/crashlytics_reporter.dart';
import 'package:marshaller/utils/exceptions/exception_level.dart';

const _appSettings = '_appSettings';

class AppSettingsLocalStorage {
  final LocalStorage _localStorage = GetIt.I<LocalStorage>();
  AsyncResult<AppSettings> getSettings() async {
    final DefaultSettingsValues defaults = DefaultSettingsValues();
    return await _localStorage.get(_appSettings).map((jsonString) {
      if (jsonString.isEmpty) {
        return defaults.toAppSettings();
      }
      final Map<String, dynamic> savedMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final AppSettings defaultSettings = defaults.toAppSettings();
      final Map<String, dynamic> defaultMap = defaultSettings.toJson();
      final Map<String, dynamic> merged = {...defaultMap, ...savedMap};
      final Map<String, dynamic> mapForFromJson = Map<String, dynamic>.from(
        merged,
      );
      final Object? notificationPrefsValue =
          mapForFromJson['notificationPreferences'];
      if (notificationPrefsValue != null &&
          notificationPrefsValue is! Map<String, dynamic>) {
        try {
          mapForFromJson['notificationPreferences'] =
              (notificationPrefsValue as dynamic).toJson()
                  as Map<String, dynamic>;
        } catch (e) {
          return defaults.toAppSettings();
        }
      }
      try {
        return AppSettings.fromJson(mapForFromJson);
      } catch (e, s) {
        CrashlyticsReporter.report(
          e.toString(),
          level: ExceptionLevel.error,
          stackTrace: s,
        );
        return defaults.toAppSettings();
      }
    });
  }

  AsyncResult<AppSettings> saveSettings(AppSettings settings) async {
    return await _localStorage
        .save(_appSettings, jsonEncode(settings.toJson()))
        .pure(settings);
  }

  AsyncResult<Unit> deleteSettings() async {
    return await _localStorage.delete(_appSettings);
  }
}
