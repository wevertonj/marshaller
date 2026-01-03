import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/ui/locations/viewmodels/location_list_state.dart';
import 'package:marshaller/ui/locations/viewmodels/location_list_viewmodel.dart';

import '../../../fixtures/location_fixtures.dart';
import '../../../mocks/mock_repositories.dart';

void main() {
  late MockRickMortyRepository mockRepository;
  late LocationListViewModel viewModel;

  setUp(() {
    mockRepository = MockRickMortyRepository();
    viewModel = LocationListViewModel(repository: mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('LocationListViewModel', () {
    test('should have LocationListInitial as initial state', () {
      expect(viewModel.state.value, isA<LocationListInitial>());
    });

    group('loadLocationsCommand', () {
      test(
        'should emit LocationListLoading then LocationListLoaded when loading succeeds',
        () async {
          final states = <LocationListState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          final paginatedResult = PaginatedResult(
            items: LocationFixtures.testLocationList,
            totalCount: 126,
            totalPages: 7,
            nextPage: 2,
            hasMore: true,
          );

          when(
            () => mockRepository.getLocations(page: 1),
          ).thenAnswer((_) async => Success(paginatedResult));

          await viewModel.loadLocationsCommand.execute((
            forceRefresh: false,
            type: null,
            dimension: null,
            name: null,
          ));

          expect(states.length, 2);
          expect(states[0], isA<LocationListLoading>());
          expect(states[1], isA<LocationListLoaded>());

          final loadedState = viewModel.state.value as LocationListLoaded;
          expect(loadedState.locations, LocationFixtures.testLocationList);
          expect(loadedState.hasMore, true);
          expect(loadedState.currentPage, 1);

          verify(() => mockRepository.getLocations(page: 1)).called(1);
        },
      );

      test(
        'should emit LocationListLoading then LocationListError when loading fails',
        () async {
          final states = <LocationListState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getLocations(page: 1),
          ).thenAnswer((_) async => Failure(Exception('Network error')));

          await viewModel.loadLocationsCommand.execute((
            forceRefresh: false,
            type: null,
            dimension: null,
            name: null,
          ));

          expect(states.length, 2);
          expect(states[0], isA<LocationListLoading>());
          expect(states[1], isA<LocationListError>());

          final errorState = viewModel.state.value as LocationListError;
          expect(errorState.message, contains('Network error'));
        },
      );
    });

    group('loadMoreCommand', () {
      test('should append locations when load more succeeds', () async {
        final firstPageResult = PaginatedResult(
          items: [LocationFixtures.testLocation],
          totalCount: 126,
          totalPages: 7,
          nextPage: 2,
          hasMore: true,
        );

        when(
          () => mockRepository.getLocations(page: 1),
        ).thenAnswer((_) async => Success(firstPageResult));

        await viewModel.loadLocationsCommand.execute((
          forceRefresh: false,
          type: null,
          dimension: null,
          name: null,
        ));

        final secondPageResult = PaginatedResult(
          items: [LocationFixtures.testLocation2],
          totalCount: 126,
          totalPages: 7,
          nextPage: 3,
          hasMore: true,
        );

        when(
          () => mockRepository.getLocations(page: 2),
        ).thenAnswer((_) async => Success(secondPageResult));

        await viewModel.loadMoreCommand.execute();

        final loadedState = viewModel.state.value as LocationListLoaded;
        expect(loadedState.locations.length, 2);
        expect(loadedState.locations[0], LocationFixtures.testLocation);
        expect(loadedState.locations[1], LocationFixtures.testLocation2);
        expect(loadedState.currentPage, 2);
        expect(loadedState.hasMore, true);
      });

      test('should not load more when hasMore is false', () async {
        final paginatedResult = PaginatedResult(
          items: LocationFixtures.testLocationList,
          totalCount: 3,
          totalPages: 1,
          nextPage: null,
          hasMore: false,
        );

        when(
          () => mockRepository.getLocations(page: 1),
        ).thenAnswer((_) async => Success(paginatedResult));

        await viewModel.loadLocationsCommand.execute((
          forceRefresh: false,
          type: null,
          dimension: null,
          name: null,
        ));

        await viewModel.loadMoreCommand.execute();

        verifyNever(() => mockRepository.getLocations(page: 2));
      });

      test(
        'should not load more when state is not LocationListLoaded',
        () async {
          await viewModel.loadMoreCommand.execute();

          verifyNever(
            () => mockRepository.getLocations(page: any(named: 'page')),
          );
        },
      );
    });
  });
}
