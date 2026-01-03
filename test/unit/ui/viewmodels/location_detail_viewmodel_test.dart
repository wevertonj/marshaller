import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/ui/locations/viewmodels/location_detail_state.dart';
import 'package:marshaller/ui/locations/viewmodels/location_detail_viewmodel.dart';

import '../../../fixtures/location_fixtures.dart';
import '../../../mocks/mock_repositories.dart';

void main() {
  late MockRickMortyRepository mockRepository;
  late LocationDetailViewModel viewModel;

  setUp(() {
    mockRepository = MockRickMortyRepository();
    viewModel = LocationDetailViewModel(repository: mockRepository);

    when(
      () => mockRepository.getMultipleCharacters(any()),
    ).thenAnswer((_) async => const Success([]));
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('LocationDetailViewModel', () {
    test('should have LocationDetailInitial as initial state', () {
      expect(viewModel.state.value, isA<LocationDetailInitial>());
    });

    group('loadLocationCommand', () {
      test(
        'should emit LocationDetailLoading then LocationDetailLoaded when loading succeeds',
        () async {
          final states = <LocationDetailState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getLocation(1),
          ).thenAnswer((_) async => Success(LocationFixtures.testLocation));

          await viewModel.loadLocationCommand.execute(1);

          expect(states.length, 2);
          expect(states[0], isA<LocationDetailLoading>());
          expect(states[1], isA<LocationDetailLoaded>());

          final loadedState = viewModel.state.value as LocationDetailLoaded;
          expect(loadedState.location, LocationFixtures.testLocation);

          verify(() => mockRepository.getLocation(1)).called(1);
        },
      );

      test(
        'should emit LocationDetailLoading then LocationDetailError when loading fails',
        () async {
          final states = <LocationDetailState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getLocation(1),
          ).thenAnswer((_) async => Failure(Exception('Location not found')));

          await viewModel.loadLocationCommand.execute(1);

          expect(states.length, 2);
          expect(states[0], isA<LocationDetailLoading>());
          expect(states[1], isA<LocationDetailError>());

          final errorState = viewModel.state.value as LocationDetailError;
          expect(errorState.message, contains('Location not found'));
        },
      );

      test('should load different locations correctly', () async {
        when(
          () => mockRepository.getLocation(1),
        ).thenAnswer((_) async => Success(LocationFixtures.testLocation));

        when(
          () => mockRepository.getLocation(2),
        ).thenAnswer((_) async => Success(LocationFixtures.testLocation2));

        await viewModel.loadLocationCommand.execute(1);

        var loadedState = viewModel.state.value as LocationDetailLoaded;
        expect(loadedState.location.id, 1);
        expect(loadedState.location.name, 'Earth (C-137)');

        await viewModel.loadLocationCommand.execute(2);

        loadedState = viewModel.state.value as LocationDetailLoaded;
        expect(loadedState.location.id, 2);
        expect(loadedState.location.name, 'Abadango');
      });
    });
  });
}
