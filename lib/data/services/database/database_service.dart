import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/domain/entities/location.dart';
import 'package:marshaller/domain/enums/character_gender.dart';
import 'package:marshaller/domain/enums/character_status.dart';
import 'package:marshaller/utils/helpers/app_logger.dart';

class DatabaseService {
  static const String _databaseName = 'marshaller_cache.db';
  static const int _databaseVersion = 1;
  Database? _database;
  DatabaseService();
  DatabaseService.withDatabase(Database database) : _database = database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);
    AppLogger.info('Initializing database at: $path');
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    AppLogger.info('Creating database tables...');
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
    await db.execute('CREATE INDEX idx_characters_name ON characters (name)');
    await db.execute(
      'CREATE INDEX idx_characters_status ON characters (status)',
    );
    await db.execute('CREATE INDEX idx_locations_name ON locations (name)');
    await db.execute(
      'CREATE INDEX idx_episodes_code ON episodes (episode_code)',
    );
    AppLogger.info('Database tables created successfully');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    AppLogger.info('Upgrading database from v$oldVersion to v$newVersion');
  }

  Future<void> saveCharacter(Character character) async {
    final db = await database;
    await db.insert(
      'characters',
      _characterToMap(character),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _saveCharacterEpisodes(character.id, character.episodeIds);
  }

  Future<void> saveCharacters(List<Character> characters) async {
    final db = await database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final character in characters) {
        batch.insert(
          'characters',
          _characterToMap(character),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
      for (final character in characters) {
        await _saveCharacterEpisodesInTxn(
          txn,
          character.id,
          character.episodeIds,
        );
      }
    });
  }

  Future<Character?> getCharacter(int id) async {
    final db = await database;
    final maps = await db.query('characters', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    final episodeIds = await _getCharacterEpisodeIds(id);
    return _characterFromMap(maps.first, episodeIds);
  }

  Future<List<Character>> getAllCharacters({int? limit, int? offset}) async {
    final db = await database;
    final maps = await db.query(
      'characters',
      limit: limit,
      offset: offset,
      orderBy: 'id ASC',
    );
    final characters = <Character>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final episodeIds = await _getCharacterEpisodeIds(id);
      characters.add(_characterFromMap(map, episodeIds));
    }
    return characters;
  }

  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final db = await database;
    final placeholders = List.filled(ids.length, '?').join(',');
    final maps = await db.query(
      'characters',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
    final characters = <Character>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final episodeIds = await _getCharacterEpisodeIds(id);
      characters.add(_characterFromMap(map, episodeIds));
    }
    return characters;
  }

  Future<bool> isCharacterCached(int id, Duration ttl) async {
    final db = await database;
    final maps = await db.query(
      'characters',
      columns: ['cached_at'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return false;
    final cachedAt = DateTime.parse(maps.first['cached_at'] as String);
    return DateTime.now().difference(cachedAt) <= ttl;
  }

  Future<void> saveLocation(Location location) async {
    final db = await database;
    await db.insert(
      'locations',
      _locationToMap(location),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _saveLocationResidents(location.id, location.residentIds);
  }

  Future<void> saveLocations(List<Location> locations) async {
    final db = await database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final location in locations) {
        batch.insert(
          'locations',
          _locationToMap(location),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
      for (final location in locations) {
        await _saveLocationResidentsInTxn(
          txn,
          location.id,
          location.residentIds,
        );
      }
    });
  }

  Future<Location?> getLocation(int id) async {
    final db = await database;
    final maps = await db.query('locations', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    final residentIds = await _getLocationResidentIds(id);
    return _locationFromMap(maps.first, residentIds);
  }

  Future<List<Location>> getAllLocations({int? limit, int? offset}) async {
    final db = await database;
    final maps = await db.query(
      'locations',
      limit: limit,
      offset: offset,
      orderBy: 'id ASC',
    );
    final locations = <Location>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final residentIds = await _getLocationResidentIds(id);
      locations.add(_locationFromMap(map, residentIds));
    }
    return locations;
  }

  Future<List<Location>> getLocationsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final db = await database;
    final placeholders = List.filled(ids.length, '?').join(',');
    final maps = await db.query(
      'locations',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
    final locations = <Location>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final residentIds = await _getLocationResidentIds(id);
      locations.add(_locationFromMap(map, residentIds));
    }
    return locations;
  }

  Future<bool> isLocationCached(int id, Duration ttl) async {
    final db = await database;
    final maps = await db.query(
      'locations',
      columns: ['cached_at'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return false;
    final cachedAt = DateTime.parse(maps.first['cached_at'] as String);
    return DateTime.now().difference(cachedAt) <= ttl;
  }

  Future<void> saveEpisode(Episode episode) async {
    final db = await database;
    await db.insert(
      'episodes',
      _episodeToMap(episode),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> saveEpisodes(List<Episode> episodes) async {
    final db = await database;
    final batch = db.batch();
    for (final episode in episodes) {
      batch.insert(
        'episodes',
        _episodeToMap(episode),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<Episode?> getEpisode(int id) async {
    final db = await database;
    final maps = await db.query('episodes', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    final characterIds = await _getEpisodeCharacterIds(id);
    return _episodeFromMap(maps.first, characterIds);
  }

  Future<List<Episode>> getAllEpisodes({int? limit, int? offset}) async {
    final db = await database;
    final maps = await db.query(
      'episodes',
      limit: limit,
      offset: offset,
      orderBy: 'id ASC',
    );
    final episodes = <Episode>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final characterIds = await _getEpisodeCharacterIds(id);
      episodes.add(_episodeFromMap(map, characterIds));
    }
    return episodes;
  }

  Future<List<Episode>> getEpisodesByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final db = await database;
    final placeholders = List.filled(ids.length, '?').join(',');
    final maps = await db.query(
      'episodes',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
    final episodes = <Episode>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final characterIds = await _getEpisodeCharacterIds(id);
      episodes.add(_episodeFromMap(map, characterIds));
    }
    return episodes;
  }

  Future<bool> isEpisodeCached(int id, Duration ttl) async {
    final db = await database;
    final maps = await db.query(
      'episodes',
      columns: ['cached_at'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return false;
    final cachedAt = DateTime.parse(maps.first['cached_at'] as String);
    return DateTime.now().difference(cachedAt) <= ttl;
  }

  Future<void> saveMetadata(String key, String value, Duration ttl) async {
    final db = await database;
    await db.insert('cache_metadata', {
      'key': key,
      'value': value,
      'cached_at': DateTime.now().toIso8601String(),
      'ttl_seconds': ttl.inSeconds,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getMetadata(String key) async {
    final db = await database;
    final maps = await db.query(
      'cache_metadata',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (maps.isEmpty) return null;
    final cachedAt = DateTime.parse(maps.first['cached_at'] as String);
    final ttl = Duration(seconds: maps.first['ttl_seconds'] as int);
    if (DateTime.now().difference(cachedAt) > ttl) {
      await db.delete('cache_metadata', where: 'key = ?', whereArgs: [key]);
      return null;
    }
    return maps.first['value'] as String;
  }

  Future<bool> isCacheValid(String key, Duration ttl) async {
    final db = await database;
    final maps = await db.query(
      'cache_metadata',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (maps.isEmpty) return false;
    final cachedAt = DateTime.parse(maps.first['cached_at'] as String);
    final storedTtl = Duration(seconds: maps.first['ttl_seconds'] as int);
    final effectiveTtl = ttl < storedTtl ? ttl : storedTtl;
    return DateTime.now().difference(cachedAt) <= effectiveTtl;
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('character_episodes');
      await txn.delete('location_residents');
      await txn.delete('characters');
      await txn.delete('locations');
      await txn.delete('episodes');
      await txn.delete('cache_metadata');
    });
    AppLogger.info('Database cache cleared');
  }

  Future<void> clearExpired(Duration ttl) async {
    final db = await database;
    final cutoff = DateTime.now().subtract(ttl).toIso8601String();
    await db.transaction((txn) async {
      await txn.delete(
        'characters',
        where: 'cached_at < ?',
        whereArgs: [cutoff],
      );
      await txn.delete(
        'locations',
        where: 'cached_at < ?',
        whereArgs: [cutoff],
      );
      await txn.delete('episodes', where: 'cached_at < ?', whereArgs: [cutoff]);
      final metadataMaps = await txn.query('cache_metadata');
      for (final map in metadataMaps) {
        final cachedAt = DateTime.parse(map['cached_at'] as String);
        final metaTtl = Duration(seconds: map['ttl_seconds'] as int);
        if (DateTime.now().difference(cachedAt) > metaTtl) {
          await txn.delete(
            'cache_metadata',
            where: 'key = ?',
            whereArgs: [map['key']],
          );
        }
      }
    });
    AppLogger.debug('Expired cache entries cleared');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  Map<String, dynamic> _characterToMap(Character character) {
    return {
      'id': character.id,
      'name': character.name,
      'status': character.status.name,
      'species': character.species,
      'type': character.type,
      'gender': character.gender.name,
      'origin_name': character.origin.name,
      'origin_url': character.origin.url,
      'location_name': character.location.name,
      'location_url': character.location.url,
      'image': character.image,
      'url': character.url,
      'created': character.created.toIso8601String(),
      'cached_at': DateTime.now().toIso8601String(),
    };
  }

  Character _characterFromMap(Map<String, dynamic> map, List<int> episodeIds) {
    return Character(
      id: map['id'] as int,
      name: map['name'] as String,
      status: CharacterStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => CharacterStatus.unknown,
      ),
      species: map['species'] as String,
      type: map['type'] as String,
      gender: CharacterGender.values.firstWhere(
        (g) => g.name == map['gender'],
        orElse: () => CharacterGender.unknown,
      ),
      origin: CharacterOrigin(
        name: map['origin_name'] as String,
        url: map['origin_url'] as String?,
      ),
      location: CharacterLocation(
        name: map['location_name'] as String,
        url: map['location_url'] as String?,
      ),
      image: map['image'] as String,
      episode: episodeIds
          .map((id) => 'https://rickandmortyapi.com/api/episode/$id')
          .toList(),
      url: map['url'] as String,
      created: DateTime.parse(map['created'] as String),
    );
  }

  Map<String, dynamic> _locationToMap(Location location) {
    return {
      'id': location.id,
      'name': location.name,
      'type': location.type,
      'dimension': location.dimension,
      'url': location.url,
      'created': location.created.toIso8601String(),
      'cached_at': DateTime.now().toIso8601String(),
    };
  }

  Location _locationFromMap(Map<String, dynamic> map, List<int> residentIds) {
    return Location(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      dimension: map['dimension'] as String,
      residents: residentIds
          .map((id) => 'https://rickandmortyapi.com/api/character/$id')
          .toList(),
      url: map['url'] as String,
      created: DateTime.parse(map['created'] as String),
    );
  }

  Map<String, dynamic> _episodeToMap(Episode episode) {
    return {
      'id': episode.id,
      'name': episode.name,
      'air_date': episode.airDate.toIso8601String(),
      'episode_code': episode.episodeCode,
      'url': episode.url,
      'created': episode.created.toIso8601String(),
      'cached_at': DateTime.now().toIso8601String(),
    };
  }

  Episode _episodeFromMap(Map<String, dynamic> map, List<int> characterIds) {
    return Episode(
      id: map['id'] as int,
      name: map['name'] as String,
      airDate: DateTime.parse(map['air_date'] as String),
      episodeCode: map['episode_code'] as String,
      characters: characterIds
          .map((id) => 'https://rickandmortyapi.com/api/character/$id')
          .toList(),
      url: map['url'] as String,
      created: DateTime.parse(map['created'] as String),
    );
  }

  Future<void> _saveCharacterEpisodes(
    int characterId,
    List<int> episodeIds,
  ) async {
    final db = await database;
    await db.delete(
      'character_episodes',
      where: 'character_id = ?',
      whereArgs: [characterId],
    );
    final batch = db.batch();
    for (final episodeId in episodeIds) {
      batch.insert('character_episodes', {
        'character_id': characterId,
        'episode_id': episodeId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit(noResult: true);
  }

  Future<void> _saveCharacterEpisodesInTxn(
    Transaction txn,
    int characterId,
    List<int> episodeIds,
  ) async {
    await txn.delete(
      'character_episodes',
      where: 'character_id = ?',
      whereArgs: [characterId],
    );
    for (final episodeId in episodeIds) {
      await txn.insert('character_episodes', {
        'character_id': characterId,
        'episode_id': episodeId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future<List<int>> _getCharacterEpisodeIds(int characterId) async {
    final db = await database;
    final maps = await db.query(
      'character_episodes',
      columns: ['episode_id'],
      where: 'character_id = ?',
      whereArgs: [characterId],
    );
    return maps.map((m) => m['episode_id'] as int).toList();
  }

  Future<void> _saveLocationResidents(
    int locationId,
    List<int> residentIds,
  ) async {
    final db = await database;
    await db.delete(
      'location_residents',
      where: 'location_id = ?',
      whereArgs: [locationId],
    );
    final batch = db.batch();
    for (final residentId in residentIds) {
      batch.insert('location_residents', {
        'location_id': locationId,
        'character_id': residentId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit(noResult: true);
  }

  Future<void> _saveLocationResidentsInTxn(
    Transaction txn,
    int locationId,
    List<int> residentIds,
  ) async {
    await txn.delete(
      'location_residents',
      where: 'location_id = ?',
      whereArgs: [locationId],
    );
    for (final residentId in residentIds) {
      await txn.insert('location_residents', {
        'location_id': locationId,
        'character_id': residentId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future<List<int>> _getLocationResidentIds(int locationId) async {
    final db = await database;
    final maps = await db.query(
      'location_residents',
      columns: ['character_id'],
      where: 'location_id = ?',
      whereArgs: [locationId],
    );
    return maps.map((m) => m['character_id'] as int).toList();
  }

  Future<List<int>> _getEpisodeCharacterIds(int episodeId) async {
    final db = await database;
    final maps = await db.query(
      'character_episodes',
      columns: ['character_id'],
      where: 'episode_id = ?',
      whereArgs: [episodeId],
    );
    return maps.map((m) => m['character_id'] as int).toList();
  }
}
