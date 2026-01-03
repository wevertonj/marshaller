class RickMortyEndpoints {
  static const String baseUrl = 'https://rickandmortyapi.com/api';
  static const String characters = '$baseUrl/character';
  static String character(int id) => '$baseUrl/character/$id';
  static String multipleCharacters(List<int> ids) =>
      '$baseUrl/character/${ids.join(",")}';
  static const String locations = '$baseUrl/location';
  static String location(int id) => '$baseUrl/location/$id';
  static String multipleLocations(List<int> ids) =>
      '$baseUrl/location/${ids.join(",")}';
  static const String episodes = '$baseUrl/episode';
  static String episode(int id) => '$baseUrl/episode/$id';
  static String multipleEpisodes(List<int> ids) =>
      '$baseUrl/episode/${ids.join(",")}';
}
