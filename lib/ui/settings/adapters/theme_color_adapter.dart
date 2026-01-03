import 'package:flutter/material.dart';
import 'package:marshaller/domain/enums/theme_options.dart';
import 'package:marshaller/domain/enums/themes_color.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/settings/adapters/settings_option_adapter.dart';

class ThemeColorAdapter extends SettingsOptionAdapter<ThemeOptions> {
  ThemeColorAdapter({required super.context, required super.settings});
  @override
  String getLabel(ThemeOptions value) {
    switch (value) {
      case ThemeOptions.green:
        return l10n.colorGreen;
      case ThemeOptions.blue:
        return l10n.colorBlue;
      case ThemeOptions.red:
        return l10n.colorRed;
      case ThemeOptions.yellow:
        return l10n.colorYellow;
      case ThemeOptions.purple:
        return l10n.colorPurple;
      case ThemeOptions.brown:
        return l10n.colorBrown;
      case ThemeOptions.orange:
        return l10n.colorOrange;
      case ThemeOptions.gray:
        return l10n.colorGray;
      case ThemeOptions.pink:
        return l10n.colorPink;
    }
  }

  @override
  ThemeOptions getSelected() {
    return settings.theme;
  }

  @override
  void onTap() {
    _showFullThemeSelection();
  }

  Future<void> _showFullThemeSelection() async {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final padding = theme.layout.padding;
        final spacing = theme.layout.spacing;
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(padding.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(l10n.themeSelect, style: const TextStyle(fontSize: 20)),
                SizedBox(height: spacing.medium),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: ThemeOptions.values.length,
                  itemBuilder: (context, index) {
                    final themeOption = ThemeOptions.values[index];
                    return GestureDetector(
                      onTap: () {
                        viewmodel.saveThemeCommand.execute(themeOption);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(
                                ThemesColor
                                    .values[themeOption.index]
                                    .colorValue,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            getLabel(themeOption),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
