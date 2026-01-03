enum LocationType {
  planet('Planet'),
  spaceStation('Space station'),
  microverse('Microverse'),
  tv('TV'),
  resort('Resort'),
  dimension('Dimension'),
  dream('Dream'),
  fantasyTown('Fantasy town'),
  menagerie('Menagerie'),
  game('Game'),
  customs('Customs'),
  daycare('Daycare'),
  spa('Spa'),
  policeStation('Police station'),
  arcade('Arcade'),
  quadrant('Quadrant'),
  spacecraft('Spacecraft'),
  mount('Mount'),
  cluster('Cluster'),
  unknown('unknown'),
  other('Other');

  final String apiValue;
  const LocationType(this.apiValue);
  static LocationType fromApiValue(String value) {
    final normalized = value.toLowerCase().trim();
    return LocationType.values.firstWhere(
      (type) => type.apiValue.toLowerCase() == normalized,
      orElse: () => LocationType.other,
    );
  }
}
