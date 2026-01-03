import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/ui/characters/viewmodels/character_detail_state.dart';
import 'package:marshaller/ui/characters/viewmodels/character_detail_viewmodel.dart';

import '../../../fixtures/character_fixtures.dart';
import '../../../mocks/mock_repositories.dart';

void main() {
  late MockRickMortyRepository mockRepository;
  late CharacterDetailViewModel viewModel;

  setUp(() {
    mockRepository = MockRickMortyRepository();
    viewModel = CharacterDetailViewModel(repository: mockRepository);

    when(
      () => mockRepository.getMultipleEpisodes(any()),
    ).thenAnswer((_) async => const Success([]));
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('CharacterDetailViewModel', () {
    test('should have CharacterDetailInitial as initial state', () {
      expect(viewModel.state.value, isA<CharacterDetailInitial>());
    });

    group('loadCharacterCommand', () {
      test(
        'should emit CharacterDetailLoading then CharacterDetailLoaded when loading succeeds',
        () async {
          final states = <CharacterDetailState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getCharacter(1),
          ).thenAnswer((_) async => Success(CharacterFixtures.testCharacter));

          await viewModel.loadCharacterCommand.execute(1);

          expect(states.length, 2);
          expect(states[0], isA<CharacterDetailLoading>());
          expect(states[1], isA<CharacterDetailLoaded>());

          final loadedState = viewModel.state.value as CharacterDetailLoaded;
          expect(loadedState.character, CharacterFixtures.testCharacter);
          expect(loadedState.character.name, 'Rick Sanchez');

          verify(() => mockRepository.getCharacter(1)).called(1);
        },
      );

      test(
        'should emit CharacterDetailLoading then CharacterDetailError when loading fails',
        () async {
          final states = <CharacterDetailState>[];
          viewModel.state.addListener(() {
            states.add(viewModel.state.value);
          });

          when(
            () => mockRepository.getCharacter(999),
          ).thenAnswer((_) async => Failure(Exception('Character not found')));

          await viewModel.loadCharacterCommand.execute(999);

          expect(states.length, 2);
          expect(states[0], isA<CharacterDetailLoading>());
          expect(states[1], isA<CharacterDetailError>());

          final errorState = viewModel.state.value as CharacterDetailError;
          expect(errorState.message, contains('Character not found'));
        },
      );

      test('should load different characters correctly', () async {
        when(
          () => mockRepository.getCharacter(1),
        ).thenAnswer((_) async => Success(CharacterFixtures.testCharacter));

        when(
          () => mockRepository.getCharacter(2),
        ).thenAnswer((_) async => Success(CharacterFixtures.testCharacter2));

        await viewModel.loadCharacterCommand.execute(1);

        var loadedState = viewModel.state.value as CharacterDetailLoaded;
        expect(loadedState.character.name, 'Rick Sanchez');

        await viewModel.loadCharacterCommand.execute(2);

        loadedState = viewModel.state.value as CharacterDetailLoaded;
        expect(loadedState.character.name, 'Morty Smith');
      });
    });
  });
}
