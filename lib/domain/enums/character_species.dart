enum CharacterSpecies {
  human('Human'),
  alien('Alien'),
  humanoid('Humanoid'),
  robot('Robot'),
  animal('Animal'),
  mythologicalCreature('Mythological Creature'),
  disease('Disease'),
  cronenberg('Cronenberg'),
  poopybutthole('Poopybutthole'),
  unknown('unknown'),
  other('Other');

  final String apiValue;
  const CharacterSpecies(this.apiValue);
  static CharacterSpecies fromApiValue(String value) {
    final normalized = value.toLowerCase().trim();
    return CharacterSpecies.values.firstWhere(
      (species) => species.apiValue.toLowerCase() == normalized,
      orElse: () => CharacterSpecies.other,
    );
  }
}
