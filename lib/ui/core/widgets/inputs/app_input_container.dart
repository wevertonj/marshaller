import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';

class AppInputContainer extends StatelessWidget {
  final Widget child;
  const AppInputContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Theme.of(context).layout.radius.small,
        ),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: child,
    );
  }
}
