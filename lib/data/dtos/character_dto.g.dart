// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDto _$CharacterDtoFromJson(Map<String, dynamic> json) => CharacterDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: json['status'] as String,
  species: json['species'] as String,
  type: json['type'] as String,
  gender: json['gender'] as String,
  origin: CharacterOriginDto.fromJson(json['origin'] as Map<String, dynamic>),
  location: CharacterLocationDto.fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  image: json['image'] as String,
  episode: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
  created: json['created'] as String,
);

Map<String, dynamic> _$CharacterDtoToJson(CharacterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };

CharacterOriginDto _$CharacterOriginDtoFromJson(Map<String, dynamic> json) =>
    CharacterOriginDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CharacterOriginDtoToJson(CharacterOriginDto instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};

CharacterLocationDto _$CharacterLocationDtoFromJson(
  Map<String, dynamic> json,
) => CharacterLocationDto(
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$CharacterLocationDtoToJson(
  CharacterLocationDto instance,
) => <String, dynamic>{'name': instance.name, 'url': instance.url};

CharacterListResponseDto _$CharacterListResponseDtoFromJson(
  Map<String, dynamic> json,
) => CharacterListResponseDto(
  info: json['info'] == null
      ? null
      : PaginationInfoDto.fromJson(json['info'] as Map<String, dynamic>),
  results: (json['results'] as List<dynamic>)
      .map((e) => CharacterDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CharacterListResponseDtoToJson(
  CharacterListResponseDto instance,
) => <String, dynamic>{'info': instance.info, 'results': instance.results};

PaginationInfoDto _$PaginationInfoDtoFromJson(Map<String, dynamic> json) =>
    PaginationInfoDto(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$PaginationInfoDtoToJson(PaginationInfoDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
