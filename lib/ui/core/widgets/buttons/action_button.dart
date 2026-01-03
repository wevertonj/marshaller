import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.layout.spacing;
    final radius = theme.layout.radius;
    final colorPrimary = theme.colorScheme.primary;
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth / 5;
        final buttonWidth = availableWidth.clamp(60.0, 120.0);
        return Card(
          color: theme.colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.small),
          ),
          child: InkWell(
            onTap: onTap ?? () {},
            borderRadius: BorderRadius.circular(radius.small),
            splashColor: colorPrimary.withValues(alpha: 0.5),
            child: SizedBox(
              width: buttonWidth,
              child: Padding(
                padding: EdgeInsets.all(spacing.tiny),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: colorPrimary, size: buttonWidth * 0.28),
                    SizedBox(height: spacing.tiny),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: buttonWidth * 0.14,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
