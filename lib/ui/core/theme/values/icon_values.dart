import 'dart:ui';

class IconValues {
  final double small;
  final double medium;
  final double large;
  final double xlarge;
  const IconValues({
    this.small = 16.0,
    this.medium = 24.0,
    this.large = 32.0,
    this.xlarge = 48.0,
  });
  IconValues copyWith({
    double? small,
    double? medium,
    double? large,
    double? xlarge,
  }) {
    return IconValues(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      xlarge: xlarge ?? this.xlarge,
    );
  }

  static IconValues lerp(IconValues a, IconValues b, double t) {
    return IconValues(
      small: lerpDouble(a.small, b.small, t) ?? a.small,
      medium: lerpDouble(a.medium, b.medium, t) ?? a.medium,
      large: lerpDouble(a.large, b.large, t) ?? a.large,
      xlarge: lerpDouble(a.xlarge, b.xlarge, t) ?? a.xlarge,
    );
  }
}
