import 'dart:ui';

class RadiusValues {
  final double small;
  final double medium;
  final double large;
  final double full;
  const RadiusValues({
    this.small = 8.0,
    this.medium = 12.0,
    this.large = 24.0,
    this.full = 100.0,
  });
  RadiusValues copyWith({
    double? small,
    double? medium,
    double? large,
    double? full,
  }) {
    return RadiusValues(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      full: full ?? this.full,
    );
  }

  static RadiusValues lerp(RadiusValues a, RadiusValues b, double t) {
    return RadiusValues(
      small: lerpDouble(a.small, b.small, t) ?? a.small,
      medium: lerpDouble(a.medium, b.medium, t) ?? a.medium,
      large: lerpDouble(a.large, b.large, t) ?? a.large,
      full: lerpDouble(a.full, b.full, t) ?? a.full,
    );
  }
}
