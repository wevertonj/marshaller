import 'dart:ui';

class SpacingValues {
  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double xlarge;
  const SpacingValues({
    this.tiny = 4.0,
    this.small = 8.0,
    this.medium = 16.0,
    this.large = 24.0,
    this.xlarge = 32.0,
  });
  SpacingValues copyWith({
    double? tiny,
    double? small,
    double? medium,
    double? large,
    double? xlarge,
  }) {
    return SpacingValues(
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      xlarge: xlarge ?? this.xlarge,
    );
  }

  static SpacingValues lerp(SpacingValues a, SpacingValues b, double t) {
    return SpacingValues(
      tiny: lerpDouble(a.tiny, b.tiny, t) ?? a.tiny,
      small: lerpDouble(a.small, b.small, t) ?? a.small,
      medium: lerpDouble(a.medium, b.medium, t) ?? a.medium,
      large: lerpDouble(a.large, b.large, t) ?? a.large,
      xlarge: lerpDouble(a.xlarge, b.xlarge, t) ?? a.xlarge,
    );
  }
}
