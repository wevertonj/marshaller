import 'package:flutter/material.dart';

class ShimmerValues {
  final Color baseColor;
  final Color highlightColor;
  const ShimmerValues({
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
  });
  ShimmerValues copyWith({Color? baseColor, Color? highlightColor}) {
    return ShimmerValues(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  static ShimmerValues lerp(ShimmerValues a, ShimmerValues b, double t) {
    return ShimmerValues(
      baseColor: Color.lerp(a.baseColor, b.baseColor, t) ?? a.baseColor,
      highlightColor:
          Color.lerp(a.highlightColor, b.highlightColor, t) ?? a.highlightColor,
    );
  }
}
