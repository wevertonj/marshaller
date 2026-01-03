import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/widgets/animations/scroll_fade_item.dart';

class SequentialFadeAnimation extends StatelessWidget {
  final List<Widget> children;
  final bool isLoading;
  final Duration itemDuration;
  final Duration delayBetweenItems;
  final Curve curve;
  final bool useListView;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  const SequentialFadeAnimation({
    super.key,
    required this.children,
    this.isLoading = false,
    this.itemDuration = const Duration(milliseconds: 400),
    this.delayBetweenItems = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.useListView = false,
    this.physics,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    if (isLoading || children.isEmpty) {
      if (useListView) {
        return ListView(
          shrinkWrap: true,
          physics: physics ?? const NeverScrollableScrollPhysics(),
          padding: padding,
          children: children,
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
    final animatedItems = List.generate(children.length, (index) {
      final itemDelay = Duration(
        milliseconds: delayBetweenItems.inMilliseconds * index,
      );
      return ScrollFadeItem(
        duration: itemDuration,
        delay: itemDelay,
        curve: curve,
        visibilityThreshold: 0.1,
        child: children[index],
      );
    });
    if (useListView) {
      return ListView(
        shrinkWrap: true,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        padding: padding,
        children: animatedItems,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: animatedItems,
    );
  }
}
