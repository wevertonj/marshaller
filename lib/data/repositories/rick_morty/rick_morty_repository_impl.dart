import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/data/services/cache/api_cache_service.dart';
import 'package:marshaller/data/services/http/rick_morty_client_http.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/domain/entities/location.dart';

class RickMortyRepositoryImpl implements RickMortyRepository {
  final RickMortyClientHttp _client = GetIt.I<RickMortyClientHttp>();
  final ApiCacheService _cache = GetIt.I<ApiCacheService>();
  @override
  AsyncResult<PaginatedResult<Character>> getCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _cache.getCharacters(
        page: page,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
      );
      if (cached != null) {
        final paginationInfo = await _cache.getPaginationInfo('characters');
        final totalCount = paginationInfo?['count'] as int? ?? cached.length;
        final totalPages = paginationInfo?['pages'] as int? ?? 1;
        final hasMore = page < totalPages;
        return Success(
          PaginatedResult(
            items: cached,
            totalCount: totalCount,
            totalPages: totalPages,
            nextPage: hasMore ? page + 1 : null,
            hasMore: hasMore,
          ),
        );
      }
    }
    final result = await _client.getCharacters(
      page: page,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
    );
    result.onSuccess((data) async {
      await _cache.setCharacters(
        data.items,
        page: page,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
      );
      await _cache.setPaginationInfo(
        'characters',
        count: data.totalCount,
        pages: data.totalPages,
      );
    });
    return result;
  }

  @override
  AsyncResult<Character> getCharacter(int id) async {
    final cached = await _cache.getCharacter(id);
    if (cached != null) {
      return Success(cached);
    }
    final result = await _client.getCharacter(id);
    result.onSuccess((character) async {
      await _cache.setCharacter(character);
    });
    return result;
  }

  @override
  AsyncResult<List<Character>> getMultipleCharacters(List<int> ids) async {
    if (ids.isEmpty) return Success([]);
    final cached = await _cache.getMultipleCharacters(ids);
    if (cached != null) {
      return Success(cached);
    }
    final result = await _client.getMultipleCharacters(ids);
    result.onSuccess((characters) async {
      await _cache.setMultipleCharacters(characters);
    });
    return result;
  }

  @override
  AsyncResult<PaginatedResult<Location>> getLocations({
    int page = 1,
    String? name,
    String? type,
    String? dimension,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _cache.getLocations(
        page: page,
        name: name,
        type: type,
        dimension: dimension,
      );
      if (cached != null) {
        final paginationInfo = await _cache.getPaginationInfo('locations');
        final totalCount = paginationInfo?['count'] as int? ?? cached.length;
        final totalPages = paginationInfo?['pages'] as int? ?? 1;
        final hasMore = page < totalPages;
        return Success(
          PaginatedResult(
            items: cached,
            totalCount: totalCount,
            totalPages: totalPages,
            nextPage: hasMore ? page + 1 : null,
            hasMore: hasMore,
          ),
        );
      }
    }
    final result = await _client.getLocations(
      page: page,
      name: name,
      type: type,
      dimension: dimension,
    );
    result.onSuccess((data) async {
      await _cache.setLocations(
        data.items,
        page: page,
        name: name,
        type: type,
        dimension: dimension,
      );
      await _cache.setPaginationInfo(
        'locations',
        count: data.totalCount,
        pages: data.totalPages,
      );
    });
    return result;
  }

  @override
  AsyncResult<Location> getLocation(int id) async {
    final cached = await _cache.getLocation(id);
    if (cached != null) {
      return Success(cached);
    }
    final result = await _client.getLocation(id);
    result.onSuccess((location) async {
      await _cache.setLocation(location);
    });
    return result;
  }

  @override
  AsyncResult<List<Location>> getMultipleLocations(List<int> ids) async {
    if (ids.isEmpty) return Success([]);
    final cached = await _cache.getMultipleLocations(ids);
    if (cached != null) {
      return Success(cached);
    }
    final result = await _client.getMultipleLocations(ids);
    result.onSuccess((locations) async {
      await _cache.setMultipleLocations(locations);
    });
    return result;
  }

  @override
  AsyncResult<PaginatedResult<Episode>> getEpisodes({
    int page = 1,
    String? name,
    String? episode,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _cache.getEpisodes(
        page: page,
        name: name,
        episode: episode,
      );
      if (cached != null) {
        final paginationInfo = await _cache.getPaginationInfo('episodes');
        final totalCount = paginationInfo?['count'] as int? ?? cached.length;
        final totalPages = paginationInfo?['pages'] as int? ?? 1;
        final hasMore = page < totalPages;
        return Success(
          PaginatedResult(
            items: cached,
            totalCount: totalCount,
            totalPages: totalPages,
            nextPage: hasMore ? page + 1 : null,
            hasMore: hasMore,
          ),
        );
      }
    }
    final result = await _client.getEpisodes(
      page: page,
      name: name,
      episode: episode,
    );
    result.onSuccess((data) async {
      await _cache.setEpisodes(
        data.items,
        page: page,
        name: name,
        episode: episode,
      );
      await _cache.setPaginationInfo(
        'episodes',
        count: data.totalCount,
        pages: data.totalPages,
      );
    });
    return result;
  }

  @override
  AsyncResult<Episode> getEpisode(int id) async {
    final cached = await _cache.getEpisode(id);
    if (cached != null) {
      return Success(cached);
    }
    final result = await _client.getEpisode(id);
    result.onSuccess((episode) async {
      await _cache.setEpisode(episode);
    });
    return result;
  }

  @override
  AsyncResult<List<Episode>> getMultipleEpisodes(List<int> ids) async {
    if (ids.isEmpty) return Success([]);
    final cached = await _cache.getMultipleEpisodes(ids);
    if (cached != null) {
      return Success(cached);
    }
    final result = await _client.getMultipleEpisodes(ids);
    result.onSuccess((episodes) async {
      await _cache.setMultipleEpisodes(episodes);
    });
    return result;
  }
}
