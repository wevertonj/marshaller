import 'package:result_dart/result_dart.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/domain/entities/location.dart';

class PaginatedResult<T> {
  final List<T> items;
  final int totalCount;
  final int totalPages;
  final int? nextPage;
  final bool hasMore;
  const PaginatedResult({
    required this.items,
    required this.totalCount,
    required this.totalPages,
    this.nextPage,
    required this.hasMore,
  });
}

abstract class RickMortyRepository {
  AsyncResult<PaginatedResult<Character>> getCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    bool forceRefresh = false,
  });
  AsyncResult<Character> getCharacter(int id);
  AsyncResult<List<Character>> getMultipleCharacters(List<int> ids);
  AsyncResult<PaginatedResult<Location>> getLocations({
    int page = 1,
    String? name,
    String? type,
    String? dimension,
    bool forceRefresh = false,
  });
  AsyncResult<Location> getLocation(int id);
  AsyncResult<List<Location>> getMultipleLocations(List<int> ids);
  AsyncResult<PaginatedResult<Episode>> getEpisodes({
    int page = 1,
    String? name,
    String? episode,
    bool forceRefresh = false,
  });
  AsyncResult<Episode> getEpisode(int id);
  AsyncResult<List<Episode>> getMultipleEpisodes(List<int> ids);
}
