// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  type: json['type'] as String,
  dimension: json['dimension'] as String,
  residents: (json['residents'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  url: json['url'] as String,
  created: json['created'] as String,
);

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
      'url': instance.url,
      'created': instance.created,
    };

LocationListResponseDto _$LocationListResponseDtoFromJson(
  Map<String, dynamic> json,
) => LocationListResponseDto(
  info: json['info'] == null
      ? null
      : PaginationInfoDto.fromJson(json['info'] as Map<String, dynamic>),
  results: (json['results'] as List<dynamic>)
      .map((e) => LocationDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LocationListResponseDtoToJson(
  LocationListResponseDto instance,
) => <String, dynamic>{'info': instance.info, 'results': instance.results};
