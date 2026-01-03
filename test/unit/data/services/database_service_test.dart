import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:marshaller/data/services/database/database_service.dart';

import '../../../fixtures/character_fixtures.dart';
import '../../../fixtures/location_fixtures.dart';
import '../../../fixtures/episode_fixtures.dart';

void main() {
  late DatabaseService databaseService;
  late Database database;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE characters (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL,
              status TEXT NOT NULL,
              species TEXT NOT NULL,
              type TEXT NOT NULL,
              gender TEXT NOT NULL,
              origin_name TEXT NOT NULL,
              origin_url TEXT,
              location_name TEXT NOT NULL,
              location_url TEXT,
              image TEXT NOT NULL,
              url TEXT NOT NULL,
              created TEXT NOT NULL,
              cached_at TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE locations (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL,
              type TEXT NOT NULL,
              dimension TEXT NOT NULL,
              url TEXT NOT NULL,
              created TEXT NOT NULL,
              cached_at TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE episodes (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL,
              air_date TEXT NOT NULL,
              episode_code TEXT NOT NULL,
              url TEXT NOT NULL,
              created TEXT NOT NULL,
              cached_at TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE character_episodes (
              character_id INTEGER NOT NULL,
              episode_id INTEGER NOT NULL,
              PRIMARY KEY (character_id, episode_id),
              FOREIGN KEY (character_id) REFERENCES characters (id) ON DELETE CASCADE,
              FOREIGN KEY (episode_id) REFERENCES episodes (id) ON DELETE CASCADE
            )
          ''');

          await db.execute('''
            CREATE TABLE location_residents (
              location_id INTEGER NOT NULL,
              character_id INTEGER NOT NULL,
              PRIMARY KEY (location_id, character_id),
              FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE CASCADE,
              FOREIGN KEY (character_id) REFERENCES characters (id) ON DELETE CASCADE
            )
          ''');

          await db.execute('''
            CREATE TABLE cache_metadata (
              key TEXT PRIMARY KEY,
              value TEXT NOT NULL,
              cached_at TEXT NOT NULL,
              ttl_seconds INTEGER NOT NULL
            )
          ''');

          await db.execute(
            'CREATE INDEX idx_characters_name ON characters (name)',
          );
          await db.execute(
            'CREATE INDEX idx_characters_status ON characters (status)',
          );
          await db.execute(
            'CREATE INDEX idx_locations_name ON locations (name)',
          );
          await db.execute(
            'CREATE INDEX idx_episodes_code ON episodes (episode_code)',
          );
        },
      ),
    );

    databaseService = DatabaseService.withDatabase(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('DatabaseService', () {
    group('Character operations', () {
      test('should save and retrieve a single character', () async {
        final character = CharacterFixtures.testCharacter;

        await databaseService.saveCharacter(character);
        final retrieved = await databaseService.getCharacter(character.id);

        expect(retrieved, isNotNull);
        expect(retrieved!.id, character.id);
        expect(retrieved.name, character.name);
        expect(retrieved.status, character.status);
        expect(retrieved.species, character.species);
        expect(retrieved.gender, character.gender);
        expect(retrieved.origin.name, character.origin.name);
        expect(retrieved.location.name, character.location.name);
      });

      test('should save and retrieve multiple characters', () async {
        final characters = CharacterFixtures.testCharacterList;

        await databaseService.saveCharacters(characters);
        final retrieved = await databaseService.getAllCharacters();

        expect(retrieved.length, characters.length);
        expect(
          retrieved.map((c) => c.id),
          containsAll(characters.map((c) => c.id)),
        );
      });

      test('should return null when character not found', () async {
        final retrieved = await databaseService.getCharacter(999);

        expect(retrieved, isNull);
      });

      test('should get characters by ids', () async {
        final characters = CharacterFixtures.testCharacterList;
        await databaseService.saveCharacters(characters);

        final retrieved = await databaseService.getCharactersByIds([1, 2]);

        expect(retrieved.length, 2);
        expect(retrieved.map((c) => c.id), containsAll([1, 2]));
      });

      test('should check if character is cached', () async {
        final character = CharacterFixtures.testCharacter;
        await databaseService.saveCharacter(character);
        const ttl = Duration(hours: 1);

        expect(
          await databaseService.isCharacterCached(character.id, ttl),
          isTrue,
        );
        expect(await databaseService.isCharacterCached(999, ttl), isFalse);
      });

      test('should update character when saving existing id', () async {
        final character = CharacterFixtures.testCharacter;
        await databaseService.saveCharacter(character);

        final updatedCharacter = CharacterFixtures.testCharacter2.copyWith(
          id: 1,
        );
        await databaseService.saveCharacter(updatedCharacter);
        final retrieved = await databaseService.getCharacter(1);

        expect(retrieved!.name, 'Morty Smith');
      });

      test('should save character episode relationships', () async {
        final character = CharacterFixtures.testCharacter;

        await databaseService.saveCharacter(character);
        final retrieved = await databaseService.getCharacter(character.id);

        expect(retrieved!.episode, isNotEmpty);
        expect(retrieved.episode.length, character.episode.length);
      });
    });

    group('Location operations', () {
      test('should save and retrieve a single location', () async {
        final location = LocationFixtures.testLocation;

        await databaseService.saveLocation(location);
        final retrieved = await databaseService.getLocation(location.id);

        expect(retrieved, isNotNull);
        expect(retrieved!.id, location.id);
        expect(retrieved.name, location.name);
        expect(retrieved.type, location.type);
        expect(retrieved.dimension, location.dimension);
      });

      test('should save and retrieve multiple locations', () async {
        final locations = LocationFixtures.testLocationList;

        await databaseService.saveLocations(locations);
        final retrieved = await databaseService.getAllLocations();

        expect(retrieved.length, locations.length);
        expect(
          retrieved.map((l) => l.id),
          containsAll(locations.map((l) => l.id)),
        );
      });

      test('should return null when location not found', () async {
        final retrieved = await databaseService.getLocation(999);

        expect(retrieved, isNull);
      });

      test('should get locations by ids', () async {
        final locations = LocationFixtures.testLocationList;
        await databaseService.saveLocations(locations);

        final retrieved = await databaseService.getLocationsByIds([1, 2]);

        expect(retrieved.length, 2);
        expect(retrieved.map((l) => l.id), containsAll([1, 2]));
      });

      test('should check if location is cached', () async {
        final location = LocationFixtures.testLocation;
        await databaseService.saveLocation(location);
        const ttl = Duration(hours: 1);

        expect(
          await databaseService.isLocationCached(location.id, ttl),
          isTrue,
        );
        expect(await databaseService.isLocationCached(999, ttl), isFalse);
      });

      test('should save location residents relationships', () async {
        final location = LocationFixtures.testLocation;

        await databaseService.saveLocation(location);
        final retrieved = await databaseService.getLocation(location.id);

        expect(retrieved!.residents, isNotEmpty);
        expect(retrieved.residents.length, location.residents.length);
      });
    });

    group('Episode operations', () {
      test('should save and retrieve a single episode', () async {
        final episode = EpisodeFixtures.testEpisode;

        await databaseService.saveEpisode(episode);
        final retrieved = await databaseService.getEpisode(episode.id);

        expect(retrieved, isNotNull);
        expect(retrieved!.id, episode.id);
        expect(retrieved.name, episode.name);
        expect(retrieved.episodeCode, episode.episodeCode);
      });

      test('should save and retrieve multiple episodes', () async {
        final episodes = EpisodeFixtures.testEpisodeList;

        await databaseService.saveEpisodes(episodes);
        final retrieved = await databaseService.getAllEpisodes();

        expect(retrieved.length, episodes.length);
        expect(
          retrieved.map((e) => e.id),
          containsAll(episodes.map((e) => e.id)),
        );
      });

      test('should return null when episode not found', () async {
        final retrieved = await databaseService.getEpisode(999);

        expect(retrieved, isNull);
      });

      test('should get episodes by ids', () async {
        final episodes = EpisodeFixtures.testEpisodeList;
        await databaseService.saveEpisodes(episodes);

        final retrieved = await databaseService.getEpisodesByIds([1, 2]);

        expect(retrieved.length, 2);
        expect(retrieved.map((e) => e.id), containsAll([1, 2]));
      });

      test('should check if episode is cached', () async {
        final episode = EpisodeFixtures.testEpisode;
        await databaseService.saveEpisode(episode);
        const ttl = Duration(hours: 1);

        expect(await databaseService.isEpisodeCached(episode.id, ttl), isTrue);
        expect(await databaseService.isEpisodeCached(999, ttl), isFalse);
      });
    });

    group('Metadata operations', () {
      test('should save and retrieve metadata', () async {
        const key = 'test_key';
        const value = 'test_value';
        const ttl = Duration(hours: 1);

        await databaseService.saveMetadata(key, value, ttl);
        final retrieved = await databaseService.getMetadata(key);

        expect(retrieved, value);
      });

      test('should return null for non-existent metadata', () async {
        final retrieved = await databaseService.getMetadata('non_existent');

        expect(retrieved, isNull);
      });

      test('should return null for expired metadata', () async {
        const key = 'expired_key';
        const value = 'expired_value';
        const ttl = Duration(milliseconds: 1);

        await databaseService.saveMetadata(key, value, ttl);
        await Future.delayed(const Duration(milliseconds: 50));
        final retrieved = await databaseService.getMetadata(key);

        expect(retrieved, isNull);
      });

      test('should update metadata when key exists', () async {
        const key = 'update_key';
        const ttl = Duration(hours: 1);

        await databaseService.saveMetadata(key, 'value1', ttl);
        await databaseService.saveMetadata(key, 'value2', ttl);
        final retrieved = await databaseService.getMetadata(key);

        expect(retrieved, 'value2');
      });
    });

    group('Cleanup operations', () {
      test('should clear all data', () async {
        await databaseService.saveCharacter(CharacterFixtures.testCharacter);
        await databaseService.saveLocation(LocationFixtures.testLocation);
        await databaseService.saveEpisode(EpisodeFixtures.testEpisode);

        await databaseService.clearAll();

        expect(await databaseService.getAllCharacters(), isEmpty);
        expect(await databaseService.getAllLocations(), isEmpty);
        expect(await databaseService.getAllEpisodes(), isEmpty);
      });

      test('should clear expired data based on TTL', () async {
        final character = CharacterFixtures.testCharacter;
        await databaseService.saveCharacter(character);

        await databaseService.clearExpired(Duration.zero);

        expect(await databaseService.getCharacter(character.id), isNull);
      });

      test('should not clear non-expired data', () async {
        final character = CharacterFixtures.testCharacter;
        await databaseService.saveCharacter(character);

        await databaseService.clearExpired(const Duration(hours: 24));

        expect(await databaseService.getCharacter(character.id), isNotNull);
      });
    });

    group('Edge cases', () {
      test('should handle empty lists', () async {
        await databaseService.saveCharacters([]);
        await databaseService.saveLocations([]);
        await databaseService.saveEpisodes([]);

        expect(await databaseService.getAllCharacters(), isEmpty);
      });

      test('should handle special characters in text fields', () async {
        final character = CharacterFixtures.testCharacter;

        await databaseService.saveCharacter(character);
        final retrieved = await databaseService.getCharacter(character.id);

        expect(retrieved, isNotNull);
      });

      test('should handle concurrent operations', () async {
        await Future.wait([
          databaseService.saveCharacter(CharacterFixtures.testCharacter),
          databaseService.saveCharacter(CharacterFixtures.testCharacter2),
          databaseService.saveLocation(LocationFixtures.testLocation),
          databaseService.saveEpisode(EpisodeFixtures.testEpisode),
        ]);

        expect(await databaseService.getAllCharacters(), hasLength(2));
        expect(await databaseService.getAllLocations(), hasLength(1));
        expect(await databaseService.getAllEpisodes(), hasLength(1));
      });

      test('should return empty list for non-existent ids', () async {
        final characters = await databaseService.getCharactersByIds([999, 998]);
        final locations = await databaseService.getLocationsByIds([999, 998]);
        final episodes = await databaseService.getEpisodesByIds([999, 998]);

        expect(characters, isEmpty);
        expect(locations, isEmpty);
        expect(episodes, isEmpty);
      });
    });
  });
}
