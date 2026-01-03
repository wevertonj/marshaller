import 'dart:ui';

class PaddingValues {
  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double page;
  const PaddingValues({
    this.tiny = 4.0,
    this.small = 8.0,
    this.medium = 16.0,
    this.large = 24.0,
    this.page = 16.0,
  });
  PaddingValues copyWith({
    double? tiny,
    double? small,
    double? medium,
    double? large,
    double? page,
  }) {
    return PaddingValues(
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      page: page ?? this.page,
    );
  }

  static PaddingValues lerp(PaddingValues a, PaddingValues b, double t) {
    return PaddingValues(
      tiny: lerpDouble(a.tiny, b.tiny, t) ?? a.tiny,
      small: lerpDouble(a.small, b.small, t) ?? a.small,
      medium: lerpDouble(a.medium, b.medium, t) ?? a.medium,
      large: lerpDouble(a.large, b.large, t) ?? a.large,
      page: lerpDouble(a.page, b.page, t) ?? a.page,
    );
  }
}
