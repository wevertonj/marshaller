import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/enums/character_gender.dart';
import 'package:marshaller/domain/enums/character_status.dart';

class CharacterFixtures {
  static final testCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: CharacterStatus.alive,
    species: 'Human',
    type: '',
    gender: CharacterGender.male,
    origin: const CharacterOrigin(
      name: 'Earth (C-137)',
      url: 'https://rickandmortyapi.com/api/location/1',
    ),
    location: const CharacterLocation(
      name: 'Citadel of Ricks',
      url: 'https://rickandmortyapi.com/api/location/3',
    ),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: const [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    url: 'https://rickandmortyapi.com/api/character/1',
    created: DateTime.parse('2017-11-04T18:48:46.250Z'),
  );

  static final testCharacter2 = Character(
    id: 2,
    name: 'Morty Smith',
    status: CharacterStatus.alive,
    species: 'Human',
    type: '',
    gender: CharacterGender.male,
    origin: const CharacterOrigin(name: 'unknown', url: ''),
    location: const CharacterLocation(
      name: 'Citadel of Ricks',
      url: 'https://rickandmortyapi.com/api/location/3',
    ),
    image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
    episode: const [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    url: 'https://rickandmortyapi.com/api/character/2',
    created: DateTime.parse('2017-11-04T18:50:21.651Z'),
  );

  static final testDeadCharacter = Character(
    id: 8,
    name: 'Adjudicator Rick',
    status: CharacterStatus.dead,
    species: 'Human',
    type: '',
    gender: CharacterGender.male,
    origin: const CharacterOrigin(name: 'unknown', url: ''),
    location: const CharacterLocation(
      name: 'Citadel of Ricks',
      url: 'https://rickandmortyapi.com/api/location/3',
    ),
    image: 'https://rickandmortyapi.com/api/character/avatar/8.jpeg',
    episode: const ['https://rickandmortyapi.com/api/episode/28'],
    url: 'https://rickandmortyapi.com/api/character/8',
    created: DateTime.parse('2017-11-04T20:03:34.737Z'),
  );

  static final testCharacterList = [testCharacter, testCharacter2];

  static Map<String, dynamic> get characterJson => {
    'id': 1,
    'name': 'Rick Sanchez',
    'status': 'Alive',
    'species': 'Human',
    'type': '',
    'gender': 'Male',
    'origin': {
      'name': 'Earth (C-137)',
      'url': 'https://rickandmortyapi.com/api/location/1',
    },
    'location': {
      'name': 'Citadel of Ricks',
      'url': 'https://rickandmortyapi.com/api/location/3',
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    'url': 'https://rickandmortyapi.com/api/character/1',
    'created': '2017-11-04T18:48:46.250Z',
  };

  static Map<String, dynamic> get charactersResponseJson => {
    'info': {
      'count': 826,
      'pages': 42,
      'next': 'https://rickandmortyapi.com/api/character?page=2',
      'prev': null,
    },
    'results': [characterJson],
  };
}
