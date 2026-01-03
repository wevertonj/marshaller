enum CharacterType {
  empty(''),
  parasite('Parasite'),
  robot('Robot'),
  humanoid('Humanoid'),
  geneticExperiment('Genetic experiment'),
  superhuman('Superhuman'),
  humanWithAntennae('Human with antennae'),
  humanWithAntsBrain('Human with ants in his eyes'),
  game('Game'),
  clone('Clone'),
  selfAware('Self-aware'),
  cyborg('Cyborg'),
  birdPerson('Bird-Person'),
  corn('Corn'),
  pickle('Pickle'),
  cat('Cat'),
  animatedCar('Sentient car'),
  unknown('unknown'),
  other('Other');

  final String apiValue;
  const CharacterType(this.apiValue);
  static CharacterType fromApiValue(String value) {
    if (value.isEmpty) return CharacterType.empty;
    final normalized = value.toLowerCase().trim();
    return CharacterType.values.firstWhere(
      (type) => type.apiValue.toLowerCase() == normalized,
      orElse: () => CharacterType.other,
    );
  }
}
