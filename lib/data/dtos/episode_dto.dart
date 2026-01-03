import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marshaller/data/dtos/character_dto.dart';
import 'package:marshaller/domain/entities/episode.dart';
part 'episode_dto.g.dart';

@JsonSerializable()
class EpisodeDto {
  final int id;
  final String name;
  @JsonKey(name: 'air_date')
  final String airDate;
  @JsonKey(name: 'episode')
  final String episodeCode;
  final List<String> characters;
  final String url;
  final String created;
  const EpisodeDto({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCode,
    required this.characters,
    required this.url,
    required this.created,
  });
  factory EpisodeDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDtoFromJson(json);
  factory EpisodeDto.fromEntity(Episode entity) {
    final airDateFormat = DateFormat('MMMM d, yyyy');
    return EpisodeDto(
      id: entity.id,
      name: entity.name,
      airDate: airDateFormat.format(entity.airDate),
      episodeCode: entity.episodeCode,
      characters: entity.characters,
      url: entity.url,
      created: entity.created.toIso8601String(),
    );
  }
  Map<String, dynamic> toJson() => _$EpisodeDtoToJson(this);
  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      airDate: _parseAirDate(airDate),
      episodeCode: episodeCode,
      characters: characters,
      url: url,
      created: DateTime.parse(created),
    );
  }

  DateTime _parseAirDate(String date) {
    try {
      final format = DateFormat('MMMM d, yyyy');
      return format.parse(date);
    } catch (_) {
      return DateTime.now();
    }
  }
}

@JsonSerializable()
class EpisodeListResponseDto {
  final PaginationInfoDto info;
  final List<EpisodeDto> results;
  const EpisodeListResponseDto({required this.info, required this.results});
  factory EpisodeListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeListResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeListResponseDtoToJson(this);
}
