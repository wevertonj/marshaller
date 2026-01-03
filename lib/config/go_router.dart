import 'package:go_router/go_router.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/ui/characters/character_detail_page.dart';
import 'package:marshaller/ui/characters/characters_page.dart';
import 'package:marshaller/ui/episodes/episode_detail_page.dart';
import 'package:marshaller/ui/episodes/episodes_page.dart';
import 'package:marshaller/ui/home/home_page.dart';
import 'package:marshaller/ui/locations/location_detail_page.dart';
import 'package:marshaller/ui/locations/locations_page.dart';
import 'package:marshaller/ui/settings/credits_page.dart';
import 'package:marshaller/ui/settings/settings_page.dart';
import 'package:marshaller/ui/seasons/season_detail_page.dart';

final goRouter = GoRouter(
  initialLocation: RouteConfig.homePath,
  errorBuilder: (context, state) => const HomePage(),
  routes: [
    GoRoute(
      name: AppRoutes.home,
      path: RouteConfig.homePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: AppRoutes.settings,
      path: RouteConfig.settingsPath,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      name: AppRoutes.credits,
      path: RouteConfig.creditsPath,
      builder: (context, state) => const CreditsPage(),
    ),
    GoRoute(
      name: AppRoutes.characters,
      path: RouteConfig.charactersPath,
      builder: (context, state) => const CharactersPage(),
    ),
    GoRoute(
      name: AppRoutes.charactersBySpecies,
      path: RouteConfig.charactersBySpeciesPath,
      builder: (context, state) {
        final species = state.pathParameters['species'];
        return CharactersPage(species: species);
      },
    ),
    GoRoute(
      name: AppRoutes.charactersByGender,
      path: RouteConfig.charactersByGenderPath,
      builder: (context, state) {
        final gender = state.pathParameters['gender'];
        return CharactersPage(gender: gender);
      },
    ),
    GoRoute(
      name: AppRoutes.charactersByType,
      path: RouteConfig.charactersByTypePath,
      builder: (context, state) {
        final type = state.pathParameters['type'];
        return CharactersPage(type: type);
      },
    ),
    GoRoute(
      name: AppRoutes.characterDetail,
      path: RouteConfig.characterDetailPath,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CharacterDetailPage(characterId: id);
      },
    ),
    GoRoute(
      name: AppRoutes.locations,
      path: RouteConfig.locationsPath,
      builder: (context, state) => const LocationsPage(),
    ),
    GoRoute(
      name: AppRoutes.locationsByType,
      path: RouteConfig.locationsByTypePath,
      builder: (context, state) {
        final type = state.pathParameters['type'];
        return LocationsPage(type: type);
      },
    ),
    GoRoute(
      name: AppRoutes.locationsByDimension,
      path: RouteConfig.locationsByDimensionPath,
      builder: (context, state) {
        final dimension = state.pathParameters['dimension'];
        return LocationsPage(dimension: dimension);
      },
    ),
    GoRoute(
      name: AppRoutes.locationDetail,
      path: RouteConfig.locationDetailPath,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return LocationDetailPage(locationId: id);
      },
    ),
    GoRoute(
      name: AppRoutes.episodes,
      path: RouteConfig.episodesPath,
      builder: (context, state) => const EpisodesPage(),
    ),
    GoRoute(
      name: AppRoutes.episodeDetail,
      path: RouteConfig.episodeDetailPath,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EpisodeDetailPage(episodeId: id);
      },
    ),
    GoRoute(
      name: AppRoutes.seasonDetail,
      path: RouteConfig.seasonDetailPath,
      builder: (context, state) {
        final seasonCode = state.pathParameters['seasonCode'] ?? '';
        return SeasonDetailPage(seasonCode: seasonCode);
      },
    ),
  ],
);
