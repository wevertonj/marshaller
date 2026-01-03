import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_list_state.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_list_viewmodel.dart';

import '../../../fixtures/episode_fixtures.dart';
import '../../../mocks/mock_repositories.dart';

void main() {
  late MockRickMortyRepository mockRepository;
  late EpisodeListViewModel viewModel;

  setUp(() {
    mockRepository = MockRickMortyRepository();
    viewModel = EpisodeListViewModel(repository: mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('EpisodeListViewModel', () {
    test('should have EpisodeListInitial as initial state', () {
      expect(viewModel.state.value, isA<EpisodeListInitial>());
    });

    group('loadEpisodesCommand', () {
      test(
        'should emit EpisodeListLoading then EpisodeListLoaded when loading succeeds',
        () async {
          final states = <EpisodeListState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          final paginatedResult = PaginatedResult(
            items: EpisodeFixtures.testEpisodeList,
            totalCount: 51,
            totalPages: 3,
            nextPage: 2,
            hasMore: true,
          );

          when(
            () => mockRepository.getEpisodes(page: 1),
          ).thenAnswer((_) async => Success(paginatedResult));

          await viewModel.loadEpisodesCommand.execute(false);

          expect(states.length, 2);
          expect(states[0], isA<EpisodeListLoading>());
          expect(states[1], isA<EpisodeListLoaded>());

          final loadedState = viewModel.state.value as EpisodeListLoaded;
          expect(loadedState.episodes, EpisodeFixtures.testEpisodeList);
          expect(loadedState.hasMore, true);
          expect(loadedState.currentPage, 1);

          verify(() => mockRepository.getEpisodes(page: 1)).called(1);
        },
      );

      test(
        'should emit EpisodeListLoading then EpisodeListError when loading fails',
        () async {
          final states = <EpisodeListState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getEpisodes(page: 1),
          ).thenAnswer((_) async => Failure(Exception('Network error')));

          await viewModel.loadEpisodesCommand.execute(false);

          expect(states.length, 2);
          expect(states[0], isA<EpisodeListLoading>());
          expect(states[1], isA<EpisodeListError>());

          final errorState = viewModel.state.value as EpisodeListError;
          expect(errorState.message, contains('Network error'));
        },
      );
    });

    group('loadMoreCommand', () {
      test('should append episodes when load more succeeds', () async {
        final firstPageResult = PaginatedResult(
          items: [EpisodeFixtures.testEpisode],
          totalCount: 51,
          totalPages: 3,
          nextPage: 2,
          hasMore: true,
        );

        when(
          () => mockRepository.getEpisodes(page: 1),
        ).thenAnswer((_) async => Success(firstPageResult));

        await viewModel.loadEpisodesCommand.execute(false);

        final secondPageResult = PaginatedResult(
          items: [EpisodeFixtures.testEpisode2],
          totalCount: 51,
          totalPages: 3,
          nextPage: 3,
          hasMore: true,
        );

        when(
          () => mockRepository.getEpisodes(page: 2),
        ).thenAnswer((_) async => Success(secondPageResult));

        await viewModel.loadMoreCommand.execute();

        final loadedState = viewModel.state.value as EpisodeListLoaded;
        expect(loadedState.episodes.length, 2);
        expect(loadedState.episodes[0], EpisodeFixtures.testEpisode);
        expect(loadedState.episodes[1], EpisodeFixtures.testEpisode2);
        expect(loadedState.currentPage, 2);
        expect(loadedState.hasMore, true);
      });

      test('should not load more when hasMore is false', () async {
        final paginatedResult = PaginatedResult(
          items: EpisodeFixtures.testEpisodeList,
          totalCount: 3,
          totalPages: 1,
          nextPage: null,
          hasMore: false,
        );

        when(
          () => mockRepository.getEpisodes(page: 1),
        ).thenAnswer((_) async => Success(paginatedResult));

        await viewModel.loadEpisodesCommand.execute(false);

        await viewModel.loadMoreCommand.execute();

        verifyNever(() => mockRepository.getEpisodes(page: 2));
      });

      test(
        'should not load more when state is not EpisodeListLoaded',
        () async {
          await viewModel.loadMoreCommand.execute();

          verifyNever(
            () => mockRepository.getEpisodes(page: any(named: 'page')),
          );
        },
      );
    });
  });
}
