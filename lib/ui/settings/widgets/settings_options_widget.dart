import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/settings/adapters/settings_option_adapter.dart';

class SettingsOptionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final SettingsOptionAdapter<dynamic> adapter;
  const SettingsOptionsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.adapter,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final layout = theme.layout;
    final spacing = layout.spacing;
    final iconTheme = layout.icon;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            adapter.getLabel(adapter.getSelected()),
            style: TextStyle(
              color: colorScheme.outline,
              fontSize: textTheme.bodyMedium!.fontSize,
            ),
          ),
          SizedBox(height: spacing.small),
          Icon(Icons.arrow_forward_ios, size: iconTheme.medium),
        ],
      ),
      onTap: () => adapter.onTap(),
    );
  }
}
