class AppRoutes {
  static const String home = 'home';
  static const String settings = 'settings';
  static const String credits = 'credits';
  static const String characters = 'characters';
  static const String characterDetail = 'characterDetail';
  static const String charactersBySpecies = 'charactersBySpecies';
  static const String charactersByGender = 'charactersByGender';
  static const String charactersByType = 'charactersByType';
  static const String locations = 'locations';
  static const String locationDetail = 'locationDetail';
  static const String locationsByType = 'locationsByType';
  static const String locationsByDimension = 'locationsByDimension';
  static const String episodes = 'episodes';
  static const String episodeDetail = 'episodeDetail';
  static const String seasonDetail = 'seasonDetail';
}

class RouteConfig {
  static const String homePath = '/';
  static const String settingsPath = '/settings';
  static const String creditsPath = '/credits';
  static const String charactersPath = '/characters';
  static const String characterDetailPath = '/characters/:id';
  static const String charactersBySpeciesPath = '/characters/species/:species';
  static const String charactersByGenderPath = '/characters/gender/:gender';
  static const String charactersByTypePath = '/characters/type/:type';
  static const String locationsPath = '/locations';
  static const String locationDetailPath = '/locations/:id';
  static const String locationsByTypePath = '/locations/type/:type';
  static const String locationsByDimensionPath =
      '/locations/dimension/:dimension';
  static const String episodesPath = '/episodes';
  static const String episodeDetailPath = '/episodes/:id';
  static const String seasonDetailPath = '/seasons/:seasonCode';
  static const Map<String, String> routeToPath = {
    AppRoutes.home: homePath,
    AppRoutes.settings: settingsPath,
    AppRoutes.credits: creditsPath,
    AppRoutes.characters: charactersPath,
    AppRoutes.characterDetail: characterDetailPath,
    AppRoutes.charactersBySpecies: charactersBySpeciesPath,
    AppRoutes.charactersByGender: charactersByGenderPath,
    AppRoutes.charactersByType: charactersByTypePath,
    AppRoutes.locations: locationsPath,
    AppRoutes.locationDetail: locationDetailPath,
    AppRoutes.locationsByType: locationsByTypePath,
    AppRoutes.locationsByDimension: locationsByDimensionPath,
    AppRoutes.episodes: episodesPath,
    AppRoutes.episodeDetail: episodeDetailPath,
    AppRoutes.seasonDetail: seasonDetailPath,
  };
}
