import 'package:json_annotation/json_annotation.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/enums/character_gender.dart';
import 'package:marshaller/domain/enums/character_status.dart';
part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterOriginDto origin;
  final CharacterLocationDto location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;
  const CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });
  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);
  factory CharacterDto.fromEntity(Character entity) {
    return CharacterDto(
      id: entity.id,
      name: entity.name,
      status: entity.status.name,
      species: entity.species,
      type: entity.type,
      gender: entity.gender.name,
      origin: CharacterOriginDto.fromEntity(entity.origin),
      location: CharacterLocationDto.fromEntity(entity.location),
      image: entity.image,
      episode: entity.episode,
      url: entity.url,
      created: entity.created.toIso8601String(),
    );
  }
  Map<String, dynamic> toJson() => _$CharacterDtoToJson(this);
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: CharacterStatus.fromString(status),
      species: species,
      type: type,
      gender: CharacterGender.fromString(gender),
      origin: origin.toEntity(),
      location: location.toEntity(),
      image: image,
      episode: episode,
      url: url,
      created: DateTime.parse(created),
    );
  }
}

@JsonSerializable()
class CharacterOriginDto {
  final String name;
  final String url;
  const CharacterOriginDto({required this.name, required this.url});
  factory CharacterOriginDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterOriginDtoFromJson(json);
  factory CharacterOriginDto.fromEntity(CharacterOrigin entity) {
    return CharacterOriginDto(name: entity.name, url: entity.url ?? '');
  }
  Map<String, dynamic> toJson() => _$CharacterOriginDtoToJson(this);
  CharacterOrigin toEntity() {
    return CharacterOrigin(name: name, url: url.isEmpty ? null : url);
  }
}

@JsonSerializable()
class CharacterLocationDto {
  final String name;
  final String url;
  const CharacterLocationDto({required this.name, required this.url});
  factory CharacterLocationDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationDtoFromJson(json);
  factory CharacterLocationDto.fromEntity(CharacterLocation entity) {
    return CharacterLocationDto(name: entity.name, url: entity.url ?? '');
  }
  Map<String, dynamic> toJson() => _$CharacterLocationDtoToJson(this);
  CharacterLocation toEntity() {
    return CharacterLocation(name: name, url: url.isEmpty ? null : url);
  }
}

@JsonSerializable()
class CharacterListResponseDto {
  final PaginationInfoDto info;
  final List<CharacterDto> results;
  const CharacterListResponseDto({required this.info, required this.results});
  factory CharacterListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterListResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterListResponseDtoToJson(this);
}

@JsonSerializable()
class PaginationInfoDto {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  const PaginationInfoDto({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });
  factory PaginationInfoDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationInfoDtoToJson(this);
  int? get nextPage {
    if (next == null) return null;
    final uri = Uri.parse(next!);
    return int.tryParse(uri.queryParameters['page'] ?? '');
  }

  bool get hasMore => next != null;
}
