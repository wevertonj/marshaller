import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';

class AppButtonOutline extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const AppButtonOutline({super.key, required this.child, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final layout = Theme.of(context).layout;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(layout.radius.small),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
