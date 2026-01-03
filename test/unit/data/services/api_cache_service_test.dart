import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:marshaller/data/services/cache/api_cache_service.dart';
import 'package:marshaller/data/services/database/database_service.dart';

import '../../../fixtures/character_fixtures.dart';
import '../../../fixtures/episode_fixtures.dart';
import '../../../fixtures/location_fixtures.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  late MockDatabaseService mockDatabaseService;
  late ApiCacheService cacheService;
  final getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(CharacterFixtures.testCharacter);
    registerFallbackValue(CharacterFixtures.testCharacterList);
    registerFallbackValue(LocationFixtures.testLocation);
    registerFallbackValue(LocationFixtures.testLocationList);
    registerFallbackValue(EpisodeFixtures.testEpisode);
    registerFallbackValue(EpisodeFixtures.testEpisodeList);
    registerFallbackValue(const Duration(minutes: 5));
  });

  setUp(() {
    mockDatabaseService = MockDatabaseService();

    if (getIt.isRegistered<DatabaseService>()) {
      getIt.unregister<DatabaseService>();
    }
    getIt.registerSingleton<DatabaseService>(mockDatabaseService);

    cacheService = ApiCacheService();
    cacheService.clearMemory();
  });

  tearDown(() {
    if (getIt.isRegistered<DatabaseService>()) {
      getIt.unregister<DatabaseService>();
    }
  });

  group('ApiCacheService', () {
    group('Character cache operations', () {
      test('should get characters from memory cache when available', () async {
        final characters = CharacterFixtures.testCharacterList;
        const page = 1;
        const cacheKey = 'characters_page_1';

        when(
          () => mockDatabaseService.saveCharacters(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setCharacters(characters, page: page);

        final result = await cacheService.getCharacters(page: page);

        expect(result, isNotNull);
        expect(result!.length, characters.length);
        expect(result.first.id, characters.first.id);

        verifyNever(() => mockDatabaseService.isCacheValid(cacheKey, any()));
        verifyNever(() => mockDatabaseService.getAllCharacters());
      });

      test(
        'should get characters from database when memory cache expired',
        () async {
          final characters = CharacterFixtures.testCharacterList;
          const page = 1;
          const cacheKey = 'characters_list';

          when(
            () => mockDatabaseService.isCacheValid(cacheKey, any()),
          ).thenAnswer((_) async => true);
          when(
            () => mockDatabaseService.getAllCharacters(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => characters);

          final result = await cacheService.getCharacters(page: page);

          expect(result, isNotNull);
          expect(result!.length, characters.length);

          verify(
            () => mockDatabaseService.isCacheValid(cacheKey, any()),
          ).called(1);
          verify(
            () => mockDatabaseService.getAllCharacters(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).called(1);
        },
      );

      test('should return null when database cache is not valid', () async {
        const page = 1;
        const cacheKey = 'characters_list';

        when(
          () => mockDatabaseService.isCacheValid(cacheKey, any()),
        ).thenAnswer((_) async => false);

        final result = await cacheService.getCharacters(page: page);

        expect(result, isNull);
        verify(
          () => mockDatabaseService.isCacheValid(cacheKey, any()),
        ).called(1);
        verifyNever(() => mockDatabaseService.getAllCharacters());
      });

      test('should set characters in both memory and database cache', () async {
        final characters = CharacterFixtures.testCharacterList;
        const page = 1;

        when(
          () => mockDatabaseService.saveCharacters(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setCharacters(characters, page: page);

        verify(() => mockDatabaseService.saveCharacters(characters)).called(1);
        verify(
          () =>
              mockDatabaseService.saveMetadata('characters_list', any(), any()),
        ).called(1);

        final cached = await cacheService.getCharacters(page: page);
        expect(cached, isNotNull);
      });

      test('should get single character from memory cache', () async {
        final character = CharacterFixtures.testCharacter;
        final cacheKey = 'character_${character.id}';

        when(
          () => mockDatabaseService.saveCharacter(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setCharacter(character);

        final result = await cacheService.getCharacter(character.id);

        expect(result, isNotNull);
        expect(result!.id, character.id);
        verifyNever(() => mockDatabaseService.isCacheValid(cacheKey, any()));
      });

      test(
        'should get single character from database when not in memory',
        () async {
          final character = CharacterFixtures.testCharacter;

          when(
            () => mockDatabaseService.getCharacter(character.id),
          ).thenAnswer((_) async => character);

          final result = await cacheService.getCharacter(character.id);

          expect(result, isNotNull);
          expect(result!.id, character.id);
          verify(
            () => mockDatabaseService.getCharacter(character.id),
          ).called(1);
        },
      );

      test('should get multiple characters by ids', () async {
        final characters = CharacterFixtures.testCharacterList;
        final ids = characters.map((c) => c.id).toList();

        when(
          () => mockDatabaseService.getCharactersByIds(ids),
        ).thenAnswer((_) async => characters);

        final result = await cacheService.getMultipleCharacters(ids);

        expect(result!.length, characters.length);
      });

      test('should fetch missing characters from database', () async {
        final character1 = CharacterFixtures.testCharacter;
        final character2 = CharacterFixtures.testCharacter2;
        final ids = [character1.id, character2.id];

        when(
          () => mockDatabaseService.getCharactersByIds(ids),
        ).thenAnswer((_) async => [character1, character2]);

        final result = await cacheService.getMultipleCharacters(ids);

        expect(result!.length, 2);
        expect(result.map((c) => c.id), containsAll(ids));
      });
    });

    group('Location cache operations', () {
      test('should get locations from memory cache when available', () async {
        final locations = LocationFixtures.testLocationList;
        const page = 1;

        when(
          () => mockDatabaseService.saveLocations(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setLocations(locations, page: page);

        final result = await cacheService.getLocations(page: page);

        expect(result, isNotNull);
        expect(result!.length, locations.length);
        verifyNever(() => mockDatabaseService.isCacheValid(any(), any()));
      });

      test('should get locations from database when not in memory', () async {
        final locations = LocationFixtures.testLocationList;
        const page = 1;
        const cacheKey = 'locations_list';

        when(
          () => mockDatabaseService.isCacheValid(cacheKey, any()),
        ).thenAnswer((_) async => true);
        when(
          () => mockDatabaseService.getAllLocations(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => locations);

        final result = await cacheService.getLocations(page: page);

        expect(result, isNotNull);
        expect(result!.length, locations.length);
        verify(
          () => mockDatabaseService.isCacheValid(cacheKey, any()),
        ).called(1);
      });

      test('should set single location', () async {
        final location = LocationFixtures.testLocation;

        when(
          () => mockDatabaseService.saveLocation(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setLocation(location);

        verify(() => mockDatabaseService.saveLocation(location)).called(1);

        final cached = await cacheService.getLocation(location.id);
        expect(cached, isNotNull);
      });

      test('should get single location from database', () async {
        final location = LocationFixtures.testLocation;

        when(
          () => mockDatabaseService.getLocation(location.id),
        ).thenAnswer((_) async => location);

        final result = await cacheService.getLocation(location.id);

        expect(result, isNotNull);
        expect(result!.id, location.id);
      });

      test('should get multiple locations by ids', () async {
        final locations = LocationFixtures.testLocationList;
        final ids = locations.map((l) => l.id).toList();

        when(
          () => mockDatabaseService.getLocationsByIds(ids),
        ).thenAnswer((_) async => locations);

        final result = await cacheService.getMultipleLocations(ids);

        expect(result!.length, locations.length);
      });
    });

    group('Episode cache operations', () {
      test('should get episodes from memory cache when available', () async {
        final episodes = EpisodeFixtures.testEpisodeList;
        const page = 1;

        when(
          () => mockDatabaseService.saveEpisodes(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setEpisodes(episodes, page: page);

        final result = await cacheService.getEpisodes(page: page);

        expect(result, isNotNull);
        expect(result!.length, episodes.length);
        verifyNever(() => mockDatabaseService.isCacheValid(any(), any()));
      });

      test('should get episodes from database when not in memory', () async {
        final episodes = EpisodeFixtures.testEpisodeList;
        const page = 1;
        const cacheKey = 'episodes_list';

        when(
          () => mockDatabaseService.isCacheValid(cacheKey, any()),
        ).thenAnswer((_) async => true);
        when(
          () => mockDatabaseService.getAllEpisodes(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => episodes);

        final result = await cacheService.getEpisodes(page: page);

        expect(result, isNotNull);
        expect(result!.length, episodes.length);
      });

      test('should set single episode', () async {
        final episode = EpisodeFixtures.testEpisode;

        when(
          () => mockDatabaseService.saveEpisode(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setEpisode(episode);

        verify(() => mockDatabaseService.saveEpisode(episode)).called(1);

        final cached = await cacheService.getEpisode(episode.id);
        expect(cached, isNotNull);
      });

      test('should get single episode from database', () async {
        final episode = EpisodeFixtures.testEpisode;

        when(
          () => mockDatabaseService.getEpisode(episode.id),
        ).thenAnswer((_) async => episode);

        final result = await cacheService.getEpisode(episode.id);

        expect(result, isNotNull);
        expect(result!.id, episode.id);
      });

      test('should get multiple episodes by ids', () async {
        final episodes = EpisodeFixtures.testEpisodeList;
        final ids = episodes.map((e) => e.id).toList();

        when(
          () => mockDatabaseService.getEpisodesByIds(ids),
        ).thenAnswer((_) async => episodes);

        final result = await cacheService.getMultipleEpisodes(ids);

        expect(result!.length, episodes.length);
      });
    });

    group('Pagination info cache', () {
      test('should get and set pagination info', () async {
        const type = 'characters';
        const count = 826;
        const pages = 42;

        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setPaginationInfo(type, count: count, pages: pages);
        final result = await cacheService.getPaginationInfo(type);

        expect(result, isNotNull);
        expect(result!['count'], count);
        expect(result['pages'], pages);
      });

      test('should return null for unknown pagination key', () async {
        final result = await cacheService.getPaginationInfo('unknown_type');

        expect(result, isNull);
      });
    });

    group('Cache clearing operations', () {
      test('should clear all caches', () async {
        final character = CharacterFixtures.testCharacter;

        when(
          () => mockDatabaseService.saveCharacter(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});
        when(() => mockDatabaseService.clearAll()).thenAnswer((_) async {});

        await cacheService.setCharacter(character);

        await cacheService.clearAllCache();

        verify(() => mockDatabaseService.clearAll()).called(1);

        when(
          () => mockDatabaseService.isCacheValid(any(), any()),
        ).thenAnswer((_) async => false);
        final cached = await cacheService.getCharacter(character.id);
        expect(cached, isNull);
      });

      test('should clear only memory cache', () async {
        final character = CharacterFixtures.testCharacter;

        when(
          () => mockDatabaseService.saveCharacter(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setCharacter(character);

        var cached = await cacheService.getCharacter(character.id);
        expect(cached, isNotNull);

        cacheService.clearMemory();

        when(
          () => mockDatabaseService.getCharacter(character.id),
        ).thenAnswer((_) async => character);

        cached = await cacheService.getCharacter(character.id);
        expect(cached, isNotNull);
        verify(() => mockDatabaseService.getCharacter(character.id)).called(1);
      });

      test('should clear expired cache', () async {
        when(
          () => mockDatabaseService.clearExpired(any()),
        ).thenAnswer((_) async {});

        await cacheService.clearExpired();

        verify(() => mockDatabaseService.clearExpired(any())).called(1);
      });
    });

    group('Error handling', () {
      test('should handle database exception on getCharacters', () async {
        const page = 1;
        const cacheKey = 'characters_list';

        when(
          () => mockDatabaseService.isCacheValid(cacheKey, any()),
        ).thenThrow(Exception('Database error'));

        final result = await cacheService.getCharacters(page: page);

        expect(result, isNull);
      });

      test('should handle database exception on setCharacters', () async {
        final characters = CharacterFixtures.testCharacterList;
        const page = 1;

        when(
          () => mockDatabaseService.saveCharacters(any()),
        ).thenThrow(Exception('Database error'));

        await cacheService.setCharacters(characters, page: page);

        final cached = await cacheService.getCharacters(page: page);
        expect(cached, isNotNull);
      });

      test('should handle database exception on clearAllCache', () async {
        when(
          () => mockDatabaseService.clearAll(),
        ).thenThrow(Exception('Database error'));

        await cacheService.clearAllCache();
      });
    });

    group('Memory cache TTL', () {
      test('should update memory cache timestamp on set', () async {
        final characters = CharacterFixtures.testCharacterList;
        const page = 1;

        when(
          () => mockDatabaseService.saveCharacters(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockDatabaseService.saveMetadata(any(), any(), any()),
        ).thenAnswer((_) async {});

        await cacheService.setCharacters(characters, page: page);

        final result = await cacheService.getCharacters(page: page);
        expect(result, isNotNull);
        verifyNever(() => mockDatabaseService.isCacheValid(any(), any()));
      });
    });
  });
}
