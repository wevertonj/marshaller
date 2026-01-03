import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/config/rick_morty_endpoints.dart';
import 'package:marshaller/data/dtos/character_dto.dart';
import 'package:marshaller/data/dtos/episode_dto.dart';
import 'package:marshaller/data/dtos/location_dto.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/data/services/http/http_error_handler.dart';
import 'package:marshaller/data/services/http/http_exceptions.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/domain/entities/location.dart';

class RickMortyClientHttp {
  final Dio _dio = Dio();
  final HttpErrorHandler _errorHandler;
  RickMortyClientHttp({required HttpErrorHandler errorHandler})
    : _errorHandler = errorHandler {
    _dio.options.baseUrl = RickMortyEndpoints.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
  AsyncResult<PaginatedResult<Character>> getCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) {
    final queryParams = _buildQueryParams(
      page: page,
      filters: {
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
      },
    );
    return _get(
      RickMortyEndpoints.characters,
      queryParameters: queryParams,
    ).map((response) {
      final dto = CharacterListResponseDto.fromJson(response.data);
      return _toPaginatedResult(
        dto.info,
        dto.results.map((e) => e.toEntity()).toList(),
      );
    });
  }

  AsyncResult<Character> getCharacter(int id) {
    return _get(RickMortyEndpoints.character(id)).map((response) {
      return CharacterDto.fromJson(response.data).toEntity();
    });
  }

  AsyncResult<List<Character>> getMultipleCharacters(List<int> ids) {
    if (ids.isEmpty) return Future.value(const Success([]));
    return _get(RickMortyEndpoints.multipleCharacters(ids)).map((response) {
      return _parseMultipleResponse<CharacterDto, Character>(
        response.data,
        CharacterDto.fromJson,
        (dto) => dto.toEntity(),
      );
    });
  }

  AsyncResult<PaginatedResult<Location>> getLocations({
    int page = 1,
    String? name,
    String? type,
    String? dimension,
  }) {
    final queryParams = _buildQueryParams(
      page: page,
      filters: {'name': name, 'type': type, 'dimension': dimension},
    );
    return _get(RickMortyEndpoints.locations, queryParameters: queryParams).map(
      (response) {
        final dto = LocationListResponseDto.fromJson(response.data);
        return _toPaginatedResult(
          dto.info,
          dto.results.map((e) => e.toEntity()).toList(),
        );
      },
    );
  }

  AsyncResult<Location> getLocation(int id) {
    return _get(RickMortyEndpoints.location(id)).map((response) {
      return LocationDto.fromJson(response.data).toEntity();
    });
  }

  AsyncResult<List<Location>> getMultipleLocations(List<int> ids) {
    if (ids.isEmpty) return Future.value(const Success([]));
    return _get(RickMortyEndpoints.multipleLocations(ids)).map((response) {
      return _parseMultipleResponse<LocationDto, Location>(
        response.data,
        LocationDto.fromJson,
        (dto) => dto.toEntity(),
      );
    });
  }

  AsyncResult<PaginatedResult<Episode>> getEpisodes({
    int page = 1,
    String? name,
    String? episode,
  }) {
    final queryParams = _buildQueryParams(
      page: page,
      filters: {'name': name, 'episode': episode},
    );
    return _get(RickMortyEndpoints.episodes, queryParameters: queryParams).map((
      response,
    ) {
      final dto = EpisodeListResponseDto.fromJson(response.data);
      return _toPaginatedResult(
        dto.info,
        dto.results.map((e) => e.toEntity()).toList(),
      );
    });
  }

  AsyncResult<Episode> getEpisode(int id) {
    return _get(RickMortyEndpoints.episode(id)).map((response) {
      return EpisodeDto.fromJson(response.data).toEntity();
    });
  }

  AsyncResult<List<Episode>> getMultipleEpisodes(List<int> ids) {
    if (ids.isEmpty) return Future.value(const Success([]));
    return _get(RickMortyEndpoints.multipleEpisodes(ids)).map((response) {
      return _parseMultipleResponse<EpisodeDto, Episode>(
        response.data,
        EpisodeDto.fromJson,
        (dto) => dto.toEntity(),
      );
    });
  }

  AsyncResult<Response> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return Success(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return Success(
          Response(
            requestOptions: e.requestOptions,
            statusCode: 404,
            data: {'info': null, 'results': []},
          ),
        );
      }
      return Failure(_handleError(e));
    }
  }

  Map<String, dynamic> _buildQueryParams({
    required int page,
    required Map<String, String?> filters,
  }) {
    return {
      'page': page.toString(),
      for (final entry in filters.entries)
        if (entry.value != null && entry.value!.isNotEmpty)
          entry.key: entry.value,
    };
  }

  PaginatedResult<T> _toPaginatedResult<T>(
    PaginationInfoDto? info,
    List<T> items,
  ) {
    return PaginatedResult(
      items: items,
      totalCount: info?.count ?? 0,
      totalPages: info?.pages ?? 0,
      nextPage: info?.nextPage,
      hasMore: info?.hasMore ?? false,
    );
  }

  List<E> _parseMultipleResponse<D, E>(
    dynamic data,
    D Function(Map<String, dynamic>) fromJson,
    E Function(D) toEntity,
  ) {
    if (data is List) {
      return data.map((json) => toEntity(fromJson(json))).toList();
    }
    return [toEntity(fromJson(data))];
  }

  HttpException _handleError(DioException error) {
    if (error.response?.statusCode == 404) {
      final data = error.response?.data;
      if (data is Map && data['error'] == 'There is nothing here') {
        return const NotFoundException('No results found');
      }
    }
    return _errorHandler.handleError(error);
  }
}
