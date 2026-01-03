import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/values/icon_values.dart';
import 'package:marshaller/ui/core/theme/values/padding_values.dart';
import 'package:marshaller/ui/core/theme/values/radius_values.dart';
import 'package:marshaller/ui/core/theme/values/shimmer_values.dart';
import 'package:marshaller/ui/core/theme/values/spacing_values.dart';

class AppLayoutTheme extends ThemeExtension<AppLayoutTheme> {
  final PaddingValues padding;
  final SpacingValues spacing;
  final RadiusValues radius;
  final IconValues icon;
  final ShimmerValues shimmer;
  const AppLayoutTheme({
    this.padding = const PaddingValues(),
    this.spacing = const SpacingValues(),
    this.radius = const RadiusValues(),
    this.icon = const IconValues(),
    this.shimmer = const ShimmerValues(),
  });
  @override
  AppLayoutTheme copyWith({
    PaddingValues? padding,
    SpacingValues? spacing,
    RadiusValues? radius,
    IconValues? icon,
    ShimmerValues? shimmer,
  }) {
    return AppLayoutTheme(
      padding: padding ?? this.padding,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      icon: icon ?? this.icon,
      shimmer: shimmer ?? this.shimmer,
    );
  }

  @override
  AppLayoutTheme lerp(ThemeExtension<AppLayoutTheme>? other, double t) {
    if (other is! AppLayoutTheme) return this;
    return AppLayoutTheme(
      padding: PaddingValues.lerp(padding, other.padding, t),
      spacing: SpacingValues.lerp(spacing, other.spacing, t),
      radius: RadiusValues.lerp(radius, other.radius, t),
      icon: IconValues.lerp(icon, other.icon, t),
      shimmer: ShimmerValues.lerp(shimmer, other.shimmer, t),
    );
  }
}
