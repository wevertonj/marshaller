// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditEntity _$CreditEntityFromJson(Map<String, dynamic> json) => CreditEntity(
  name: json['name'] as String,
  author: json['author'] as String,
  license: json['license'] as String,
  source: json['source'] as String?,
  url: json['url'] as String?,
  image: json['image'] as String?,
  type: $enumDecode(_$CreditTypeEnumMap, json['type']),
);

Map<String, dynamic> _$CreditEntityToJson(CreditEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'author': instance.author,
      'license': instance.license,
      'source': instance.source,
      'url': instance.url,
      'image': instance.image,
      'type': _$CreditTypeEnumMap[instance.type]!,
    };

const _$CreditTypeEnumMap = {
  CreditType.animation: 'animation',
  CreditType.library: 'library',
  CreditType.asset: 'asset',
};
