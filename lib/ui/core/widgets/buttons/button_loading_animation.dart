import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';

mixin ButtonLoadingAnimation<T extends StatefulWidget>
    on State<T>, TickerProvider {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool get isLoading;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 0.0)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading && mounted) {
        _animationController.value = 1.0;
      }
    });
  }

  void updateLoadingState(bool oldIsLoading) {
    if (oldIsLoading != isLoading) {
      if (isLoading) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildButtonContent(Widget child, Color indicatorColor) {
    final spacingSmall = Theme.of(context).layout.spacing.small;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_fadeAnimation.value > 0.01)
              Opacity(
                opacity: _fadeAnimation.value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: indicatorColor,
                        strokeWidth: 1.5,
                      ),
                    ),
                    SizedBox(width: spacingSmall * _fadeAnimation.value),
                  ],
                ),
              ),
            SlideTransition(position: _slideAnimation, child: child),
          ],
        );
      },
    );
  }
}
