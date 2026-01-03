import 'package:flutter/material.dart';
import 'package:marshaller/ui/settings/adapters/settings_option_adapter.dart';

class ThemeModeAdapter extends SettingsOptionAdapter<ThemeMode> {
  ThemeModeAdapter({required super.context, required super.settings});
  @override
  String getLabel(ThemeMode value) {
    switch (value) {
      case ThemeMode.system:
        return l10n.system;
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
    }
  }

  @override
  ThemeMode getSelected() {
    return settings.darkMode;
  }

  @override
  void onTap() {
    _showModeDialog();
  }

  Future<void> _showModeDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.modeSelect),
          content: RadioGroup<ThemeMode>(
            groupValue: settings.darkMode,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                viewmodel.saveDarkModeCommand.execute(value);
                Navigator.of(context).pop();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ThemeMode.values.map((mode) {
                return ListTile(
                  title: Text(getLabel(mode)),
                  leading: Radio<ThemeMode>(value: mode),
                  onTap: () {
                    viewmodel.saveDarkModeCommand.execute(mode);
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
