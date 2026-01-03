import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/enums/app_locale.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/settings/adapters/theme_color_adapter.dart';
import 'package:marshaller/ui/settings/viewmodels/settings_viewmodel.dart';
import 'package:marshaller/ui/settings/widgets/settings_options_widget.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final viewmodel = GetIt.I<SettingsViewModel>();
  @override
  void initState() {
    super.initState();
    viewmodel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    viewmodel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.layout.spacing;
    final l10n = AppLocalizations.of(context);
    final settings = viewmodel.settings;
    return AppScaffold(
      title: Text(l10n.settings),
      showMenuButton: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spacing.large),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.medium,
                vertical: spacing.small,
              ),
              child: Text(
                l10n.preferences,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined),
              title: Text(l10n.mode),
              subtitle: Text(_getThemeModeLabel(settings.darkMode, l10n)),
              onTap: () => _showThemeModeDialog(context, settings.darkMode),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              subtitle: Text(_getLocaleLabel(settings.locale, l10n)),
              onTap: () => _showLocaleDialog(context, settings.locale),
            ),
            SettingsOptionsWidget(
              title: l10n.theme,
              icon: Icons.color_lens_outlined,
              adapter: ThemeColorAdapter(context: context, settings: settings),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.credits),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                AppNavigation.pushNamed(AppRoutes.credits);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeLabel(ThemeMode mode, AppLocalizations l10n) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.system;
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
    }
  }

  void _showThemeModeDialog(BuildContext context, ThemeMode currentMode) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.modeSelect),
          content: RadioGroup<ThemeMode>(
            groupValue: currentMode,
            onChanged: (val) {
              if (val != null) {
                viewmodel.saveDarkModeCommand.execute(val);
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ThemeMode.values.map((mode) {
                return ListTile(
                  title: Text(_getThemeModeLabel(mode, l10n)),
                  leading: Radio<ThemeMode>(value: mode),
                  onTap: () {
                    viewmodel.saveDarkModeCommand.execute(mode);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  String _getLocaleLabel(AppLocale locale, AppLocalizations l10n) {
    switch (locale) {
      case AppLocale.system:
        return l10n.systemDefault;
      case AppLocale.en:
        return 'English';
      case AppLocale.es:
        return 'Español';
      case AppLocale.pt:
        return 'Português';
    }
  }

  void _showLocaleDialog(BuildContext context, AppLocale currentLocale) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.language),
          content: RadioGroup<AppLocale>(
            groupValue: currentLocale,
            onChanged: (val) {
              if (val != null) {
                viewmodel.saveLocaleCommand.execute(val);
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AppLocale.values.map((locale) {
                return ListTile(
                  title: Text(_getLocaleLabel(locale, l10n)),
                  leading: Radio<AppLocale>(value: locale),
                  onTap: () {
                    viewmodel.saveLocaleCommand.execute(locale);
                    Navigator.pop(context);
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
