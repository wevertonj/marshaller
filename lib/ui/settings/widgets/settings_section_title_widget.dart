import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';

class SettingsSectionTitleWidget extends StatelessWidget {
  final String title;
  const SettingsSectionTitleWidget({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final spacing = theme.layout.spacing;
    return Padding(
      padding: EdgeInsets.only(left: spacing.medium, bottom: spacing.small / 2),
      child: Text(
        title,
        style: TextStyle(
          fontSize: textTheme.bodyLarge!.fontSize,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
