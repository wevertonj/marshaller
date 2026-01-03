import 'package:equatable/equatable.dart';
import 'package:marshaller/domain/enums/character_gender.dart';
import 'package:marshaller/domain/enums/character_status.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final CharacterOrigin origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;
  const Character({
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
  List<int> get episodeIds {
    return episode
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
    status,
    species,
    type,
    gender,
    origin,
    location,
    image,
    episode,
    url,
    created,
  ];
  Character copyWith({
    int? id,
    String? name,
    CharacterStatus? status,
    String? species,
    String? type,
    CharacterGender? gender,
    CharacterOrigin? origin,
    CharacterLocation? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }
}

class CharacterOrigin extends Equatable {
  final String name;
  final String? url;
  const CharacterOrigin({required this.name, this.url});
  int? get id {
    if (url == null || url!.isEmpty) return null;
    final parts = url!.split('/');
    return int.tryParse(parts.last);
  }

  @override
  List<Object?> get props => [name, url];
}

class CharacterLocation extends Equatable {
  final String name;
  final String? url;
  const CharacterLocation({required this.name, this.url});
  int? get id {
    if (url == null || url!.isEmpty) return null;
    final parts = url!.split('/');
    return int.tryParse(parts.last);
  }

  @override
  List<Object?> get props => [name, url];
}
