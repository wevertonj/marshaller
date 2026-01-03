import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:marshaller/ui/core/widgets/animations/animation_fade_item.dart';

class ScrollFadeItem extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double visibilityThreshold;
  const ScrollFadeItem({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.visibilityThreshold = 0.1,
  });
  @override
  State<ScrollFadeItem> createState() => _ScrollFadeItemState();
}

class _ScrollFadeItemState extends State<ScrollFadeItem> {
  final GlobalKey<AnimationFadeItemState> _animationKey =
      GlobalKey<AnimationFadeItemState>();
  bool _hasBecomingVisible = false;
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('scroll-fade-item-${widget.hashCode}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > widget.visibilityThreshold &&
            !_hasBecomingVisible) {
          _hasBecomingVisible = true;
          final animationState = _animationKey.currentState;
          if (animationState != null) {
            Future.delayed(widget.delay, () {
              if (animationState.mounted) {
                animationState.startAnimation();
              }
            });
          }
        }
      },
      child: AnimationFadeItem(
        key: _animationKey,
        duration: widget.duration,
        curve: widget.curve,
        autoStart: false,
        child: widget.child,
      ),
    );
  }
}
