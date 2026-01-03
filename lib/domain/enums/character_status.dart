enum CharacterStatus {
  alive,
  dead,
  unknown;

  static CharacterStatus fromString(String value) {
    return switch (value.toLowerCase()) {
      'alive' => CharacterStatus.alive,
      'dead' => CharacterStatus.dead,
      _ => CharacterStatus.unknown,
    };
  }

  String toApiString() {
    return switch (this) {
      CharacterStatus.alive => 'Alive',
      CharacterStatus.dead => 'Dead',
      CharacterStatus.unknown => 'unknown',
    };
  }
}
