import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'credit_entity.g.dart';

enum CreditType { animation, library, asset }

@JsonSerializable()
class CreditEntity extends Equatable {
  final String name;
  final String author;
  final String license;
  final String? source;
  final String? url;
  final String? image;
  final CreditType type;
  const CreditEntity({
    required this.name,
    required this.author,
    required this.license,
    this.source,
    this.url,
    this.image,
    required this.type,
  });
  factory CreditEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CreditEntityToJson(this);
  @override
  List<Object?> get props => [name, author, license, source, url, image, type];
}
