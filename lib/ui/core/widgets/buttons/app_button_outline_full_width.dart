import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/buttons/button_loading_animation.dart';

class AppButtonOutlineFullWidth extends StatefulWidget {
  final Widget child;
  final void Function()? onPressed;
  final bool isLoading;
  const AppButtonOutlineFullWidth({
    super.key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
  });
  @override
  State<AppButtonOutlineFullWidth> createState() =>
      _AppButtonOutlineFullWidthState();
}

class _AppButtonOutlineFullWidthState extends State<AppButtonOutlineFullWidth>
    with SingleTickerProviderStateMixin, ButtonLoadingAnimation {
  @override
  bool get isLoading => widget.isLoading;
  @override
  void didUpdateWidget(AppButtonOutlineFullWidth oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateLoadingState(oldWidget.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final layout = Theme.of(context).layout;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(
            color: widget.isLoading
                ? colorScheme.primary.withValues(alpha: 0.5)
                : colorScheme.primary,
            width: 2,
          ),
          disabledForegroundColor: colorScheme.primary,
          padding: EdgeInsets.symmetric(vertical: layout.padding.medium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius.medium),
          ),
          textStyle: textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: textTheme.labelLarge!.fontSize! + 2,
          ),
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: buildButtonContent(widget.child, colorScheme.primary),
      ),
    );
  }
}
