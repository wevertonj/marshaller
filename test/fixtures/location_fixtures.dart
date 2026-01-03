import 'package:marshaller/domain/entities/location.dart';

class LocationFixtures {
  static final testLocation = Location(
    id: 1,
    name: 'Earth (C-137)',
    type: 'Planet',
    dimension: 'Dimension C-137',
    residents: const [
      'https://rickandmortyapi.com/api/character/38',
      'https://rickandmortyapi.com/api/character/45',
    ],
    url: 'https://rickandmortyapi.com/api/location/1',
    created: DateTime.parse('2017-11-10T12:42:04.162Z'),
  );

  static final testLocation2 = Location(
    id: 2,
    name: 'Abadango',
    type: 'Cluster',
    dimension: 'unknown',
    residents: const ['https://rickandmortyapi.com/api/character/6'],
    url: 'https://rickandmortyapi.com/api/location/2',
    created: DateTime.parse('2017-11-10T13:06:38.182Z'),
  );

  static final testLocation3 = Location(
    id: 3,
    name: 'Citadel of Ricks',
    type: 'Space station',
    dimension: 'unknown',
    residents: const [
      'https://rickandmortyapi.com/api/character/8',
      'https://rickandmortyapi.com/api/character/14',
    ],
    url: 'https://rickandmortyapi.com/api/location/3',
    created: DateTime.parse('2017-11-10T13:08:13.191Z'),
  );

  static final testLocationList = [testLocation, testLocation2, testLocation3];

  static Map<String, dynamic> get locationJson => {
    'id': 1,
    'name': 'Earth (C-137)',
    'type': 'Planet',
    'dimension': 'Dimension C-137',
    'residents': [
      'https://rickandmortyapi.com/api/character/38',
      'https://rickandmortyapi.com/api/character/45',
    ],
    'url': 'https://rickandmortyapi.com/api/location/1',
    'created': '2017-11-10T12:42:04.162Z',
  };

  static Map<String, dynamic> get locationsResponseJson => {
    'info': {
      'count': 126,
      'pages': 7,
      'next': 'https://rickandmortyapi.com/api/location?page=2',
      'prev': null,
    },
    'results': [locationJson],
  };
}
