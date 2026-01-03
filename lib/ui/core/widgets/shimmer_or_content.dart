import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/animations/fade_in.dart';

class ShimmerOrContent extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const ShimmerOrContent({
    super.key,
    required this.isLoading,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shimmer = theme.layout.shimmer;
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: shimmer.baseColor,
        highlightColor: shimmer.highlightColor,
        child: child,
      );
    } else {
      return FadeIn(child: child);
    }
  }
}
