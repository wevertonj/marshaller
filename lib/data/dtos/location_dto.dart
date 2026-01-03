import 'package:json_annotation/json_annotation.dart';
import 'package:marshaller/data/dtos/character_dto.dart';
import 'package:marshaller/domain/entities/location.dart';
part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;
  const LocationDto({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });
  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
  factory LocationDto.fromEntity(Location entity) {
    return LocationDto(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      dimension: entity.dimension,
      residents: entity.residents,
      url: entity.url,
      created: entity.created.toIso8601String(),
    );
  }
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
  Location toEntity() {
    return Location(
      id: id,
      name: name,
      type: type,
      dimension: dimension,
      residents: residents,
      url: url,
      created: DateTime.parse(created),
    );
  }
}

@JsonSerializable()
class LocationListResponseDto {
  final PaginationInfoDto info;
  final List<LocationDto> results;
  const LocationListResponseDto({required this.info, required this.results});
  factory LocationListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LocationListResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationListResponseDtoToJson(this);
}
