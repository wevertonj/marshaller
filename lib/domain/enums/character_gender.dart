enum CharacterGender {
  female,
  male,
  genderless,
  unknown;

  static CharacterGender fromString(String value) {
    return switch (value.toLowerCase()) {
      'female' => CharacterGender.female,
      'male' => CharacterGender.male,
      'genderless' => CharacterGender.genderless,
      _ => CharacterGender.unknown,
    };
  }

  String toApiString() {
    return switch (this) {
      CharacterGender.female => 'Female',
      CharacterGender.male => 'Male',
      CharacterGender.genderless => 'Genderless',
      CharacterGender.unknown => 'unknown',
    };
  }
}
