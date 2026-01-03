import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/buttons/button_loading_animation.dart';

class AppButtonPrimary extends StatefulWidget {
  final Widget child;
  final void Function()? onPressed;
  final bool isLoading;
  const AppButtonPrimary({
    super.key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
  });
  @override
  State<AppButtonPrimary> createState() => _AppButtonPrimaryState();
}

class _AppButtonPrimaryState extends State<AppButtonPrimary>
    with SingleTickerProviderStateMixin, ButtonLoadingAnimation {
  @override
  bool get isLoading => widget.isLoading;
  @override
  void didUpdateWidget(AppButtonPrimary oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateLoadingState(oldWidget.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final layout = Theme.of(context).layout;
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(layout.radius.small),
        ),
        textStyle: textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: textTheme.labelLarge!.fontSize! + 2,
        ),
      ),
      onPressed: widget.isLoading ? null : widget.onPressed,
      child: buildButtonContent(widget.child, colorScheme.onPrimary),
    );
  }
}
