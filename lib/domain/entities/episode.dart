import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final DateTime airDate;
  final String episodeCode;
  final List<String> characters;
  final String url;
  final DateTime created;
  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCode,
    required this.characters,
    required this.url,
    required this.created,
  });
  int get seasonNumber {
    final match = RegExp(r'S(\d+)E\d+').firstMatch(episodeCode);
    return match != null ? int.parse(match.group(1)!) : 0;
  }

  int get episodeNumber {
    final match = RegExp(r'S\d+E(\d+)').firstMatch(episodeCode);
    return match != null ? int.parse(match.group(1)!) : 0;
  }

  int get characterCount => characters.length;
  List<int> get characterIds {
    return characters
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
    airDate,
    episodeCode,
    characters,
    url,
    created,
  ];
  Episode copyWith({
    int? id,
    String? name,
    DateTime? airDate,
    String? episodeCode,
    List<String>? characters,
    String? url,
    DateTime? created,
  }) {
    return Episode(
      id: id ?? this.id,
      name: name ?? this.name,
      airDate: airDate ?? this.airDate,
      episodeCode: episodeCode ?? this.episodeCode,
      characters: characters ?? this.characters,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }
}
