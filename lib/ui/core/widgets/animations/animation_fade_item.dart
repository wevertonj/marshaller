import 'package:flutter/material.dart';

class AnimationFadeItem extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool autoStart;
  const AnimationFadeItem({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.autoStart = true,
  });
  @override
  State<AnimationFadeItem> createState() => AnimationFadeItemState();
}

class AnimationFadeItemState extends State<AnimationFadeItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  bool _hasStartedAnimation = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    if (widget.autoStart) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          startAnimation();
        }
      });
    }
  }

  void startAnimation() {
    if (!_hasStartedAnimation && mounted) {
      _hasStartedAnimation = true;
      _controller.forward();
    }
  }

  bool get isAnimationCompleted =>
      _controller.status == AnimationStatus.completed;
  void resetAnimation() {
    if (mounted) {
      _hasStartedAnimation = false;
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _opacity.value)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
