import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/ui/episodes/viewmodels/episode_detail_state.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_detail_viewmodel.dart';

import '../../../fixtures/episode_fixtures.dart';
import '../../../mocks/mock_repositories.dart';

void main() {
  late MockRickMortyRepository mockRepository;
  late EpisodeDetailViewModel viewModel;

  setUp(() {
    mockRepository = MockRickMortyRepository();
    viewModel = EpisodeDetailViewModel(repository: mockRepository);

    when(
      () => mockRepository.getMultipleCharacters(any()),
    ).thenAnswer((_) async => const Success([]));
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('EpisodeDetailViewModel', () {
    test('should have EpisodeDetailInitial as initial state', () {
      expect(viewModel.state.value, isA<EpisodeDetailInitial>());
    });

    group('loadEpisodeCommand', () {
      test(
        'should emit EpisodeDetailLoading then EpisodeDetailLoaded when loading succeeds',
        () async {
          final states = <EpisodeDetailState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getEpisode(1),
          ).thenAnswer((_) async => Success(EpisodeFixtures.testEpisode));

          await viewModel.loadEpisodeCommand.execute(1);

          expect(states.length, 2);
          expect(states[0], isA<EpisodeDetailLoading>());
          expect(states[1], isA<EpisodeDetailLoaded>());

          final loadedState = viewModel.state.value as EpisodeDetailLoaded;
          expect(loadedState.episode, EpisodeFixtures.testEpisode);

          verify(() => mockRepository.getEpisode(1)).called(1);
        },
      );

      test(
        'should emit EpisodeDetailLoading then EpisodeDetailError when loading fails',
        () async {
          final states = <EpisodeDetailState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getEpisode(1),
          ).thenAnswer((_) async => Failure(Exception('Episode not found')));

          await viewModel.loadEpisodeCommand.execute(1);

          expect(states.length, 2);
          expect(states[0], isA<EpisodeDetailLoading>());
          expect(states[1], isA<EpisodeDetailError>());

          final errorState = viewModel.state.value as EpisodeDetailError;
          expect(errorState.message, contains('Episode not found'));
        },
      );

      test('should load different episodes correctly', () async {
        when(
          () => mockRepository.getEpisode(1),
        ).thenAnswer((_) async => Success(EpisodeFixtures.testEpisode));

        when(
          () => mockRepository.getEpisode(2),
        ).thenAnswer((_) async => Success(EpisodeFixtures.testEpisode2));

        await viewModel.loadEpisodeCommand.execute(1);

        var loadedState = viewModel.state.value as EpisodeDetailLoaded;
        expect(loadedState.episode.id, 1);
        expect(loadedState.episode.name, 'Pilot');

        await viewModel.loadEpisodeCommand.execute(2);

        loadedState = viewModel.state.value as EpisodeDetailLoaded;
        expect(loadedState.episode.id, 2);
        expect(loadedState.episode.name, 'Lawnmower Dog');
      });
    });
  });
}
