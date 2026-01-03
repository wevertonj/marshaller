import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final DateTime created;
  const Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });
  int get residentCount => residents.length;
  List<int> get residentIds {
    return residents
        .map((url) {
          final parts = url.split('/');
          return int.tryParse(parts.last);
        })
        .whereType<int>()
        .toList();
  }

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    dimension,
    residents,
    url,
    created,
  ];
  Location copyWith({
    int? id,
    String? name,
    String? type,
    String? dimension,
    List<String>? residents,
    String? url,
    DateTime? created,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dimension: dimension ?? this.dimension,
      residents: residents ?? this.residents,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }
}
