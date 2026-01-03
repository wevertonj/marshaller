import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:marshaller/data/services/database/database_service.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/domain/entities/location.dart';
import 'package:marshaller/utils/helpers/app_logger.dart';

class ApiCacheService {
  final Map<String, dynamic> _memoryCache = {};
  final Map<String, DateTime> _memoryCacheTimestamp = {};
  final Duration memoryListTtl;
  final Duration memoryItemTtl;
  final Duration databaseListTtl;
  final Duration databaseItemTtl;
  ApiCacheService({
    this.memoryListTtl = const Duration(minutes: 2),
    this.memoryItemTtl = const Duration(minutes: 5),
    this.databaseListTtl = const Duration(days: 7),
    this.databaseItemTtl = const Duration(days: 7),
  });
  DatabaseService get _db => GetIt.I<DatabaseService>();
  Future<List<Character>?> getCharacters({
    String? status,
    String? species,
    String? type,
    String? gender,
    String? name,
    int? page,
  }) async {
    final key = _buildKey('characters', {
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'name': name,
      'page': page,
    });
    if (_isMemoryCacheValid(key, memoryListTtl)) {
      AppLogger.debug('Cache hit (memory): characters');
      return _memoryCache[key] as List<Character>?;
    }
    final hasFilters =
        status != null ||
        species != null ||
        type != null ||
        gender != null ||
        name != null;
    if (hasFilters) {
      return null;
    }
    try {
      if (await _db.isCacheValid('characters_list', databaseListTtl)) {
        final characters = await _db.getAllCharacters(
          limit: 20,
          offset: ((page ?? 1) - 1) * 20,
        );
        if (characters.isNotEmpty) {
          _setMemoryCache(key, characters);
          AppLogger.debug('Cache hit (db): characters');
          return characters;
        }
      }
    } catch (e) {
      AppLogger.warning('Cache read error (characters): $e');
    }
    return null;
  }

  Future<void> setCharacters(
    List<Character> characters, {
    String? status,
    String? species,
    String? type,
    String? gender,
    String? name,
    int? page,
  }) async {
    final key = _buildKey('characters', {
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'name': name,
      'page': page,
    });
    _setMemoryCache(key, characters);
    try {
      await _db.saveCharacters(characters);
      await _db.saveMetadata('characters_list', 'updated', databaseListTtl);
      AppLogger.debug('Cache saved: characters (${characters.length} items)');
    } catch (e) {
      AppLogger.warning('Cache write error (characters): $e');
    }
  }

  Future<Character?> getCharacter(int id) async {
    final key = 'character_$id';
    if (_isMemoryCacheValid(key, memoryItemTtl)) {
      AppLogger.debug('Cache hit (memory): character $id');
      return _memoryCache[key] as Character?;
    }
    try {
      final character = await _db.getCharacter(id);
      if (character != null) {
        _setMemoryCache(key, character);
        AppLogger.debug('Cache hit (db): character $id');
        return character;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (character $id): $e');
    }
    return null;
  }

  Future<void> setCharacter(Character character) async {
    final key = 'character_${character.id}';
    _setMemoryCache(key, character);
    try {
      await _db.saveCharacter(character);
      AppLogger.debug('Cache saved: character ${character.id}');
    } catch (e) {
      AppLogger.warning('Cache write error (character ${character.id}): $e');
    }
  }

  Future<List<Character>?> getMultipleCharacters(List<int> ids) async {
    final key = 'characters_${ids.join('_')}';
    if (_isMemoryCacheValid(key, memoryItemTtl)) {
      AppLogger.debug('Cache hit (memory): multiple characters');
      return _memoryCache[key] as List<Character>?;
    }
    try {
      final characters = await _db.getCharactersByIds(ids);
      if (characters.length == ids.length) {
        _setMemoryCache(key, characters);
        AppLogger.debug('Cache hit (db): multiple characters');
        return characters;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (multiple characters): $e');
    }
    return null;
  }

  Future<void> setMultipleCharacters(List<Character> characters) async {
    final ids = characters.map((c) => c.id).toList();
    final key = 'characters_${ids.join('_')}';
    _setMemoryCache(key, characters);
    try {
      await _db.saveCharacters(characters);
      AppLogger.debug('Cache saved: ${characters.length} characters');
    } catch (e) {
      AppLogger.warning('Cache write error (multiple characters): $e');
    }
  }

  Future<List<Location>?> getLocations({
    String? type,
    String? dimension,
    String? name,
    int? page,
  }) async {
    final key = _buildKey('locations', {
      'type': type,
      'dimension': dimension,
      'name': name,
      'page': page,
    });
    if (_isMemoryCacheValid(key, memoryListTtl)) {
      AppLogger.debug('Cache hit (memory): locations');
      return _memoryCache[key] as List<Location>?;
    }
    final hasFilters = type != null || dimension != null || name != null;
    if (hasFilters) {
      return null;
    }
    try {
      if (await _db.isCacheValid('locations_list', databaseListTtl)) {
        final locations = await _db.getAllLocations(
          limit: 20,
          offset: ((page ?? 1) - 1) * 20,
        );
        if (locations.isNotEmpty) {
          _setMemoryCache(key, locations);
          AppLogger.debug('Cache hit (db): locations');
          return locations;
        }
      }
    } catch (e) {
      AppLogger.warning('Cache read error (locations): $e');
    }
    return null;
  }

  Future<void> setLocations(
    List<Location> locations, {
    String? type,
    String? dimension,
    String? name,
    int? page,
  }) async {
    final key = _buildKey('locations', {
      'type': type,
      'dimension': dimension,
      'name': name,
      'page': page,
    });
    _setMemoryCache(key, locations);
    try {
      await _db.saveLocations(locations);
      await _db.saveMetadata('locations_list', 'updated', databaseListTtl);
      AppLogger.debug('Cache saved: locations (${locations.length} items)');
    } catch (e) {
      AppLogger.warning('Cache write error (locations): $e');
    }
  }

  Future<Location?> getLocation(int id) async {
    final key = 'location_$id';
    if (_isMemoryCacheValid(key, memoryItemTtl)) {
      AppLogger.debug('Cache hit (memory): location $id');
      return _memoryCache[key] as Location?;
    }
    try {
      final location = await _db.getLocation(id);
      if (location != null) {
        _setMemoryCache(key, location);
        AppLogger.debug('Cache hit (db): location $id');
        return location;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (location $id): $e');
    }
    return null;
  }

  Future<void> setLocation(Location location) async {
    final key = 'location_${location.id}';
    _setMemoryCache(key, location);
    try {
      await _db.saveLocation(location);
      AppLogger.debug('Cache saved: location ${location.id}');
    } catch (e) {
      AppLogger.warning('Cache write error (location ${location.id}): $e');
    }
  }

  Future<List<Location>?> getMultipleLocations(List<int> ids) async {
    final key = 'locations_${ids.join('_')}';
    if (_isMemoryCacheValid(key, memoryItemTtl)) {
      AppLogger.debug('Cache hit (memory): multiple locations');
      return _memoryCache[key] as List<Location>?;
    }
    try {
      final locations = await _db.getLocationsByIds(ids);
      if (locations.length == ids.length) {
        _setMemoryCache(key, locations);
        AppLogger.debug('Cache hit (db): multiple locations');
        return locations;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (multiple locations): $e');
    }
    return null;
  }

  Future<void> setMultipleLocations(List<Location> locations) async {
    final ids = locations.map((l) => l.id).toList();
    final key = 'locations_${ids.join('_')}';
    _setMemoryCache(key, locations);
    try {
      await _db.saveLocations(locations);
      AppLogger.debug('Cache saved: ${locations.length} locations');
    } catch (e) {
      AppLogger.warning('Cache write error (multiple locations): $e');
    }
  }

  Future<List<Episode>?> getEpisodes({
    String? name,
    String? episode,
    int? page,
  }) async {
    final key = _buildKey('episodes', {
      'name': name,
      'episode': episode,
      'page': page,
    });
    if (_isMemoryCacheValid(key, memoryListTtl)) {
      AppLogger.debug('Cache hit (memory): episodes');
      return _memoryCache[key] as List<Episode>?;
    }
    try {
      if (await _db.isCacheValid('episodes_list', databaseListTtl)) {
        final episodes = await _db.getAllEpisodes(
          limit: 20,
          offset: ((page ?? 1) - 1) * 20,
        );
        if (episodes.isNotEmpty) {
          _setMemoryCache(key, episodes);
          AppLogger.debug('Cache hit (db): episodes');
          return episodes;
        }
      }
    } catch (e) {
      AppLogger.warning('Cache read error (episodes): $e');
    }
    return null;
  }

  Future<void> setEpisodes(
    List<Episode> episodes, {
    String? name,
    String? episode,
    int? page,
  }) async {
    final key = _buildKey('episodes', {
      'name': name,
      'episode': episode,
      'page': page,
    });
    _setMemoryCache(key, episodes);
    try {
      await _db.saveEpisodes(episodes);
      await _db.saveMetadata('episodes_list', 'updated', databaseListTtl);
      AppLogger.debug('Cache saved: episodes (${episodes.length} items)');
    } catch (e) {
      AppLogger.warning('Cache write error (episodes): $e');
    }
  }

  Future<Episode?> getEpisode(int id) async {
    final key = 'episode_$id';
    if (_isMemoryCacheValid(key, memoryItemTtl)) {
      AppLogger.debug('Cache hit (memory): episode $id');
      return _memoryCache[key] as Episode?;
    }
    try {
      final episode = await _db.getEpisode(id);
      if (episode != null) {
        _setMemoryCache(key, episode);
        AppLogger.debug('Cache hit (db): episode $id');
        return episode;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (episode $id): $e');
    }
    return null;
  }

  Future<void> setEpisode(Episode episode) async {
    final key = 'episode_${episode.id}';
    _setMemoryCache(key, episode);
    try {
      await _db.saveEpisode(episode);
      AppLogger.debug('Cache saved: episode ${episode.id}');
    } catch (e) {
      AppLogger.warning('Cache write error (episode ${episode.id}): $e');
    }
  }

  Future<List<Episode>?> getMultipleEpisodes(List<int> ids) async {
    final key = 'episodes_${ids.join('_')}';
    if (_isMemoryCacheValid(key, memoryItemTtl)) {
      AppLogger.debug('Cache hit (memory): multiple episodes');
      return _memoryCache[key] as List<Episode>?;
    }
    try {
      final episodes = await _db.getEpisodesByIds(ids);
      if (episodes.length == ids.length) {
        _setMemoryCache(key, episodes);
        AppLogger.debug('Cache hit (db): multiple episodes');
        return episodes;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (multiple episodes): $e');
    }
    return null;
  }

  Future<void> setMultipleEpisodes(List<Episode> episodes) async {
    final ids = episodes.map((e) => e.id).toList();
    final key = 'episodes_${ids.join('_')}';
    _setMemoryCache(key, episodes);
    try {
      await _db.saveEpisodes(episodes);
      AppLogger.debug('Cache saved: ${episodes.length} episodes');
    } catch (e) {
      AppLogger.warning('Cache write error (multiple episodes): $e');
    }
  }

  Future<Map<String, dynamic>?> getPaginationInfo(String type) async {
    final key = 'pagination_$type';
    if (_isMemoryCacheValid(key, memoryListTtl)) {
      return _memoryCache[key] as Map<String, dynamic>?;
    }
    try {
      final value = await _db.getMetadata(key);
      if (value != null) {
        final data = jsonDecode(value) as Map<String, dynamic>;
        _setMemoryCache(key, data);
        return data;
      }
    } catch (e) {
      AppLogger.warning('Cache read error (pagination $type): $e');
    }
    return null;
  }

  Future<void> setPaginationInfo(
    String type, {
    required int count,
    required int pages,
  }) async {
    final key = 'pagination_$type';
    final data = {'count': count, 'pages': pages};
    _setMemoryCache(key, data);
    try {
      await _db.saveMetadata(key, jsonEncode(data), databaseListTtl);
    } catch (e) {
      AppLogger.warning('Cache write error (pagination $type): $e');
    }
  }

  Future<void> clearAllCache() async {
    _memoryCache.clear();
    _memoryCacheTimestamp.clear();
    try {
      await _db.clearAll();
      AppLogger.info('Cache cleared');
    } catch (e) {
      AppLogger.warning('Cache clear error: $e');
    }
  }

  void clearMemory() {
    _memoryCache.clear();
    _memoryCacheTimestamp.clear();
    AppLogger.debug('Memory cache cleared');
  }

  Future<void> clearExpired() async {
    final keysToRemove = <String>[];
    for (final entry in _memoryCacheTimestamp.entries) {
      if (DateTime.now().difference(entry.value) > memoryListTtl) {
        keysToRemove.add(entry.key);
      }
    }
    for (final key in keysToRemove) {
      _memoryCache.remove(key);
      _memoryCacheTimestamp.remove(key);
    }
    try {
      await _db.clearExpired(databaseListTtl);
    } catch (e) {
      AppLogger.warning('Clear expired cache error: $e');
    }
  }

  void clearByType(String type) {
    final keysToRemove = _memoryCache.keys
        .where((k) => k.startsWith(type))
        .toList();
    for (final key in keysToRemove) {
      _memoryCache.remove(key);
      _memoryCacheTimestamp.remove(key);
    }
    AppLogger.debug('Memory cache cleared for type: $type');
  }

  String _buildKey(String prefix, Map<String, dynamic> params) {
    final buffer = StringBuffer(prefix);
    final sortedKeys = params.keys.toList()..sort();
    for (final key in sortedKeys) {
      final value = params[key];
      if (value != null) {
        buffer.write('_${key}_$value');
      }
    }
    return buffer.toString();
  }

  bool _isMemoryCacheValid(String key, Duration ttl) {
    final timestamp = _memoryCacheTimestamp[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) <= ttl &&
        _memoryCache.containsKey(key);
  }

  void _setMemoryCache(String key, dynamic value) {
    _memoryCache[key] = value;
    _memoryCacheTimestamp[key] = DateTime.now();
  }
}
