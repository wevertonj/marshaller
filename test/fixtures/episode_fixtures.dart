import 'package:marshaller/domain/entities/episode.dart';

class EpisodeFixtures {
  static final testEpisode = Episode(
    id: 1,
    name: 'Pilot',
    airDate: DateTime(2013, 12, 2),
    episodeCode: 'S01E01',
    characters: const [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    url: 'https://rickandmortyapi.com/api/episode/1',
    created: DateTime.parse('2017-11-10T12:56:33.798Z'),
  );

  static final testEpisode2 = Episode(
    id: 2,
    name: 'Lawnmower Dog',
    airDate: DateTime(2013, 12, 9),
    episodeCode: 'S01E02',
    characters: const [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    url: 'https://rickandmortyapi.com/api/episode/2',
    created: DateTime.parse('2017-11-10T12:56:33.916Z'),
  );

  static final testEpisode3 = Episode(
    id: 3,
    name: 'Anatomy Park',
    airDate: DateTime(2013, 12, 16),
    episodeCode: 'S01E03',
    characters: const [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    url: 'https://rickandmortyapi.com/api/episode/3',
    created: DateTime.parse('2017-11-10T12:56:34.022Z'),
  );

  static final testEpisodeList = [testEpisode, testEpisode2, testEpisode3];

  static Map<String, dynamic> get episodeJson => {
    'id': 1,
    'name': 'Pilot',
    'air_date': 'December 2, 2013',
    'episode': 'S01E01',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/1',
    'created': '2017-11-10T12:56:33.798Z',
  };

  static Map<String, dynamic> get episodesResponseJson => {
    'info': {
      'count': 51,
      'pages': 3,
      'next': 'https://rickandmortyapi.com/api/episode?page=2',
      'prev': null,
    },
    'results': [episodeJson],
  };
}
