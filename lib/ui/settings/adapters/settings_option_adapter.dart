import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/domain/entities/app_settings.dart';
import 'package:marshaller/ui/settings/viewmodels/settings_viewmodel.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

abstract class SettingsOptionAdapter<T> {
  final BuildContext context;
  final AppSettings settings;
  final SettingsViewModel viewmodel = GetIt.I<SettingsViewModel>();
  AppLocalizations get l10n => AppLocalizations.of(context);
  SettingsOptionAdapter({required this.context, required this.settings});
  String getLabel(T value);
  T getSelected();
  void onTap();
}
